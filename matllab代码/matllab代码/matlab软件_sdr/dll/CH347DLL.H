typedef unsigned long  ULONG; 
typedef unsigned char  UCHAR;
typedef int            BOOL;
typedef void*         HANDLE;
#ifdef __cplusplus
extern "C" {
#endif 

BOOL __stdcall CH347GPIO_Set(ULONG iIndex,
                             UCHAR iEnable,
                             UCHAR iSetDirOut,
                             UCHAR iSetDataOut);


BOOL __stdcall CH347GPIO_Get(ULONG iIndex,    
		  UCHAR *iDir,        
		  UCHAR *iData);    
BOOL __stdcall CH347CloseDevice(ULONG iIndex);
//BOOL __stdcallI CH347CloseDevice(ULONG iIndex);
HANDLE __stdcall CH347OpenDevice(ULONG DevI);


#ifdef __cplusplus
}
#endif