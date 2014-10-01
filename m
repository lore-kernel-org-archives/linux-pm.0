From: Christophe Thil <christophe@thil.de>
Subject: Bug#763320: linux-image-3.16-2-amd64: intel_idle enabled for Intel Atom S1260, causes high CPU temperature when idle
Date: Wed, 1 Oct 2014 14:42:48 +0200
Message-ID: <269B8283-9171-4EBD-9852-0796A4AA2008@thil.de>
References: <20140929095709.3255.93208.reportbug@izoard.lan> <1412035987.9388.72.camel@decadent.org.uk> <542A461D.9060900@siemens.com>
Reply-To: Christophe Thil <christophe@thil.de>, 763320@bugs.debian.org
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: multipart/signed; boundary="Apple-Mail=_A90CDE06-7B29-4DD8-AD82-2EC6FF736A81"; protocol="application/pkcs7-signature"; micalg=sha1
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.763320.B763320.14121673757622@bugs.debian.org>
In-Reply-To: <542A461D.9060900@siemens.com>
List-URL: <http://lists.debian.org/debian-bugs-dist/>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Ben Hutchings <ben@decadent.org.uk>, Len Brown <len.brown@intel.com>, 763320@bugs.debian.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--Apple-Mail=_A90CDE06-7B29-4DD8-AD82-2EC6FF736A81
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_C42D8B43-6B56-42E2-8A59-FDDE90B77C47"


--Apple-Mail=_C42D8B43-6B56-42E2-8A59-FDDE90B77C47
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

I have attached the output of /proc/cpuinfo (kernel 3.16-2-amd64) and =
cpuid (20140123).

Regards,
Christophe


--Apple-Mail=_C42D8B43-6B56-42E2-8A59-FDDE90B77C47
Content-Disposition: attachment;
	filename=cpuid.txt
Content-Type: text/plain;
	name="cpuid.txt"
Content-Transfer-Encoding: quoted-printable

CPU 0:
   vendor_id =3D "GenuineIntel"
   version information (1/eax):
      processor type  =3D primary processor (0)
      family          =3D Intel Pentium Pro/II/III/Celeron/Core/Core =
2/Atom, AMD Athlon/Duron, Cyrix M2, VIA C3 (6)
      model           =3D 0x6 (6)
      stepping id     =3D 0x9 (9)
      extended family =3D 0x0 (0)
      extended model  =3D 0x3 (3)
      (simple synth)  =3D Intel Atom D2000/N2000 (Cedarview), 32nm
   miscellaneous (1/ebx):
      process local APIC physical ID =3D 0x0 (0)
      cpu count                      =3D 0x4 (4)
      CLFLUSH line size              =3D 0x8 (8)
      brand index                    =3D 0x0 (0)
   brand id =3D 0x00 (0): unknown
   feature information (1/edx):
      x87 FPU on chip                        =3D true
      virtual-8086 mode enhancement          =3D true
      debugging extensions                   =3D true
      page size extensions                   =3D true
      time stamp counter                     =3D true
      RDMSR and WRMSR support                =3D true
      physical address extensions            =3D true
      machine check exception                =3D true
      CMPXCHG8B inst.                        =3D true
      APIC on chip                           =3D true
      SYSENTER and SYSEXIT                   =3D true
      memory type range registers            =3D true
      PTE global bit                         =3D true
      machine check architecture             =3D true
      conditional move/compare instruction   =3D true
      page attribute table                   =3D true
      page size extension                    =3D true
      processor serial number                =3D false
      CLFLUSH instruction                    =3D true
      debug store                            =3D true
      thermal monitor and clock ctrl         =3D true
      MMX Technology                         =3D true
      FXSAVE/FXRSTOR                         =3D true
      SSE extensions                         =3D true
      SSE2 extensions                        =3D true
      self snoop                             =3D true
      hyper-threading / multi-core supported =3D true
      therm. monitor                         =3D true
      IA64                                   =3D false
      pending break event                    =3D true
   feature information (1/ecx):
      PNI/SSE3: Prescott New Instructions     =3D true
      PCLMULDQ instruction                    =3D false
      64-bit debug store                      =3D true
      MONITOR/MWAIT                           =3D true
      CPL-qualified debug store               =3D true
      VMX: virtual machine extensions         =3D true
      SMX: safer mode extensions              =3D false
      Enhanced Intel SpeedStep Technology     =3D true
      thermal monitor 2                       =3D true
      SSSE3 extensions                        =3D true
      context ID: adaptive or shared L1 data  =3D false
      FMA instruction                         =3D false
      CMPXCHG16B instruction                  =3D true
      xTPR disable                            =3D true
      perfmon and debug                       =3D true
      process context identifiers             =3D false
      direct cache access                     =3D false
      SSE4.1 extensions                       =3D false
      SSE4.2 extensions                       =3D false
      extended xAPIC support                  =3D false
      MOVBE instruction                       =3D true
      POPCNT instruction                      =3D false
      time stamp counter deadline             =3D false
      AES instruction                         =3D false
      XSAVE/XSTOR states                      =3D false
      OS-enabled XSAVE/XSTOR                  =3D false
      AVX: advanced vector extensions         =3D false
      F16C half-precision convert instruction =3D false
      RDRAND instruction                      =3D false
      hypervisor guest status                 =3D false
   cache and TLB information (2):
      0x59: data TLB: 4K pages, 16 entries
      0xba: data TLB: 4K, 4-way, 64 entries
      0x4f: instruction TLB: 4K pages, 32 entries
      0xc0: data TLB: 4K & 4M pages, 4-way, 8 entries
      0x80: L2 cache: 512K, 8-way, 64 byte lines
      0x30: L1 cache: 32K, 8-way, 64 byte lines
      0x0e: L1 data cache: 24K, 6-way, 64 byte lines
   processor serial number: 0003-0669-0000-0000-0000-0000
   deterministic cache parameters (4):
      --- cache 0 ---
      cache type                           =3D data cache (1)
      cache level                          =3D 0x1 (1)
      self-initializing cache level        =3D true
      fully associative cache              =3D false
      extra threads sharing this cache     =3D 0x1 (1)
      extra processor cores on this die    =3D 0x1 (1)
      system coherency line size           =3D 0x3f (63)
      physical line partitions             =3D 0x0 (0)
      ways of associativity                =3D 0x5 (5)
      WBINVD/INVD behavior on lower caches =3D true
      inclusive to lower caches            =3D false
      complex cache indexing               =3D false
      number of sets - 1 (s)               =3D 63
      --- cache 1 ---
      cache type                           =3D instruction cache (2)
      cache level                          =3D 0x1 (1)
      self-initializing cache level        =3D true
      fully associative cache              =3D false
      extra threads sharing this cache     =3D 0x1 (1)
      extra processor cores on this die    =3D 0x1 (1)
      system coherency line size           =3D 0x3f (63)
      physical line partitions             =3D 0x0 (0)
      ways of associativity                =3D 0x7 (7)
      WBINVD/INVD behavior on lower caches =3D true
      inclusive to lower caches            =3D false
      complex cache indexing               =3D false
      number of sets - 1 (s)               =3D 63
      --- cache 2 ---
      cache type                           =3D unified cache (3)
      cache level                          =3D 0x2 (2)
      self-initializing cache level        =3D true
      fully associative cache              =3D false
      extra threads sharing this cache     =3D 0x1 (1)
      extra processor cores on this die    =3D 0x1 (1)
      system coherency line size           =3D 0x3f (63)
      physical line partitions             =3D 0x0 (0)
      ways of associativity                =3D 0x7 (7)
      WBINVD/INVD behavior on lower caches =3D true
      inclusive to lower caches            =3D false
      complex cache indexing               =3D false
      number of sets - 1 (s)               =3D 1023
   MONITOR/MWAIT (5):
      smallest monitor-line size (bytes)       =3D 0x40 (64)
      largest monitor-line size (bytes)        =3D 0x40 (64)
      enum of Monitor-MWAIT exts supported     =3D true
      supports intrs as break-event for MWAIT  =3D true
      number of C0 sub C-states using MWAIT    =3D 0x0 (0)
      number of C1 sub C-states using MWAIT    =3D 0x2 (2)
      number of C2 sub C-states using MWAIT    =3D 0x2 (2)
      number of C3 sub C-states using MWAIT    =3D 0x0 (0)
      number of C4 sub C-states using MWAIT    =3D 0x2 (2)
      number of C5 sub C-states using MWAIT    =3D 0x0 (0)
      number of C6 sub C-states using MWAIT    =3D 0x3 (3)
      number of C7 sub C-states using MWAIT    =3D 0x0 (0)
   Thermal and Power Management Features (6):
      digital thermometer                     =3D true
      Intel Turbo Boost Technology            =3D false
      ARAT always running APIC timer          =3D true
      PLN power limit notification            =3D false
      ECMD extended clock modulation duty     =3D false
      PTM package thermal management          =3D false
      digital thermometer thresholds          =3D 0x2 (2)
      ACNT/MCNT supported performance measure =3D true
      ACNT2 available                         =3D false
      performance-energy bias capability      =3D false
   extended feature flags (7):
      FSGSBASE instructions                    =3D false
      IA32_TSC_ADJUST MSR supported            =3D false
      BMI instruction                          =3D false
      HLE hardware lock elision                =3D false
      AVX2: advanced vector extensions 2       =3D false
      SMEP supervisor mode exec protection     =3D false
      BMI2 instructions                        =3D false
      enhanced REP MOVSB/STOSB                 =3D false
      INVPCID instruction                      =3D false
      RTM: restricted transactional memory     =3D false
      QM: quality of service monitoring        =3D false
      deprecated FPU CS/DS                     =3D false
      intel memory protection extensions       =3D false
      AVX512F: AVX-512 foundation instructions =3D false
      RDSEED instruction                       =3D false
      ADX instructions                         =3D false
      SMAP: supervisor mode access prevention  =3D false
      Intel processor trace                    =3D false
      AVX512PF: prefetch instructions          =3D false
      AVX512ER: exponent & reciprocal instrs   =3D false
      AVX512CD: conflict detection instrs      =3D false
      SHA instructions                         =3D false
      PREFETCHWT1                              =3D false
   Direct Cache Access Parameters (9):
      PLATFORM_DCA_CAP MSR bits =3D 0
   Architecture Performance Monitoring Features (0xa/eax):
      version ID                               =3D 0x3 (3)
      number of counters per logical processor =3D 0x2 (2)
      bit width of counter                     =3D 0x28 (40)
      length of EBX bit vector                 =3D 0x7 (7)
   Architecture Performance Monitoring Features (0xa/ebx):
      core cycle event not available           =3D false
      instruction retired event not available  =3D false
      reference cycles event not available     =3D false
      last-level cache ref event not available =3D false
      last-level cache miss event not avail    =3D false
      branch inst retired event not available  =3D false
      branch mispred retired event not avail   =3D false
   Architecture Performance Monitoring Features (0xa/edx):
      number of fixed counters    =3D 0x3 (3)
      bit width of fixed counters =3D 0x28 (40)
   extended feature flags (0x80000001/edx):
      SYSCALL and SYSRET instructions        =3D true
      execution disable                      =3D true
      1-GB large page support                =3D false
      RDTSCP                                 =3D false
      64-bit extensions technology available =3D true
   Intel feature flags (0x80000001/ecx):
      LAHF/SAHF supported in 64-bit mode     =3D true
      LZCNT advanced bit manipulation        =3D false
      3DNow! PREFETCH/PREFETCHW instructions =3D false
   brand =3D "        Intel(R) Atom(TM) CPU S1260   @ 2.00GHz"
   L1 TLB/cache information: 2M/4M pages & L1 TLB (0x80000005/eax):
      instruction # entries     =3D 0x0 (0)
      instruction associativity =3D 0x0 (0)
      data # entries            =3D 0x0 (0)
      data associativity        =3D 0x0 (0)
   L1 TLB/cache information: 4K pages & L1 TLB (0x80000005/ebx):
      instruction # entries     =3D 0x0 (0)
      instruction associativity =3D 0x0 (0)
      data # entries            =3D 0x0 (0)
      data associativity        =3D 0x0 (0)
   L1 data cache information (0x80000005/ecx):
      line size (bytes) =3D 0x0 (0)
      lines per tag     =3D 0x0 (0)
      associativity     =3D 0x0 (0)
      size (Kb)         =3D 0x0 (0)
   L1 instruction cache information (0x80000005/edx):
      line size (bytes) =3D 0x0 (0)
      lines per tag     =3D 0x0 (0)
      associativity     =3D 0x0 (0)
      size (Kb)         =3D 0x0 (0)
   L2 TLB/cache information: 2M/4M pages & L2 TLB (0x80000006/eax):
      instruction # entries     =3D 0x0 (0)
      instruction associativity =3D L2 off (0)
      data # entries            =3D 0x0 (0)
      data associativity        =3D L2 off (0)
   L2 TLB/cache information: 4K pages & L2 TLB (0x80000006/ebx):
      instruction # entries     =3D 0x0 (0)
      instruction associativity =3D L2 off (0)
      data # entries            =3D 0x0 (0)
      data associativity        =3D L2 off (0)
   L2 unified cache information (0x80000006/ecx):
      line size (bytes) =3D 0x40 (64)
      lines per tag     =3D 0x0 (0)
      associativity     =3D 8-way (6)
      size (Kb)         =3D 0x200 (512)
   L3 cache information (0x80000006/edx):
      line size (bytes)     =3D 0x0 (0)
      lines per tag         =3D 0x0 (0)
      associativity         =3D L2 off (0)
      size (in 512Kb units) =3D 0x0 (0)
   Advanced Power Management Features (0x80000007/edx):
      temperature sensing diode      =3D false
      frequency ID (FID) control     =3D false
      voltage ID (VID) control       =3D false
      thermal trip (TTP)             =3D false
      thermal monitor (TM)           =3D false
      software thermal control (STC) =3D false
      100 MHz multiplier control     =3D false
      hardware P-State control       =3D false
      TscInvariant                   =3D true
   Physical Address and Linear Address Size (0x80000008/eax):
      maximum physical address bits         =3D 0x24 (36)
      maximum linear (virtual) address bits =3D 0x30 (48)
      maximum guest physical address bits   =3D 0x0 (0)
   Logical CPU cores (0x80000008/ecx):
      number of CPU cores - 1 =3D 0x0 (0)
      ApicIdCoreIdSize        =3D 0x0 (0)
   (multi-processing synth): multi-core (c=3D2), hyper-threaded (t=3D2)
   (multi-processing method): Intel leaf 1/4
   (APIC widths synth): CORE_width=3D1 SMT_width=3D1
   (APIC synth): PKG_ID=3D0 CORE_ID=3D0 SMT_ID=3D0
   (synth) =3D Intel Atom D2000/N2000 (Cedarview), 32nm
CPU 1:
   vendor_id =3D "GenuineIntel"
   version information (1/eax):
      processor type  =3D primary processor (0)
      family          =3D Intel Pentium Pro/II/III/Celeron/Core/Core =
2/Atom, AMD Athlon/Duron, Cyrix M2, VIA C3 (6)
      model           =3D 0x6 (6)
      stepping id     =3D 0x9 (9)
      extended family =3D 0x0 (0)
      extended model  =3D 0x3 (3)
      (simple synth)  =3D Intel Atom D2000/N2000 (Cedarview), 32nm
   miscellaneous (1/ebx):
      process local APIC physical ID =3D 0x1 (1)
      cpu count                      =3D 0x4 (4)
      CLFLUSH line size              =3D 0x8 (8)
      brand index                    =3D 0x0 (0)
   brand id =3D 0x00 (0): unknown
   feature information (1/edx):
      x87 FPU on chip                        =3D true
      virtual-8086 mode enhancement          =3D true
      debugging extensions                   =3D true
      page size extensions                   =3D true
      time stamp counter                     =3D true
      RDMSR and WRMSR support                =3D true
      physical address extensions            =3D true
      machine check exception                =3D true
      CMPXCHG8B inst.                        =3D true
      APIC on chip                           =3D true
      SYSENTER and SYSEXIT                   =3D true
      memory type range registers            =3D true
      PTE global bit                         =3D true
      machine check architecture             =3D true
      conditional move/compare instruction   =3D true
      page attribute table                   =3D true
      page size extension                    =3D true
      processor serial number                =3D false
      CLFLUSH instruction                    =3D true
      debug store                            =3D true
      thermal monitor and clock ctrl         =3D true
      MMX Technology                         =3D true
      FXSAVE/FXRSTOR                         =3D true
      SSE extensions                         =3D true
      SSE2 extensions                        =3D true
      self snoop                             =3D true
      hyper-threading / multi-core supported =3D true
      therm. monitor                         =3D true
      IA64                                   =3D false
      pending break event                    =3D true
   feature information (1/ecx):
      PNI/SSE3: Prescott New Instructions     =3D true
      PCLMULDQ instruction                    =3D false
      64-bit debug store                      =3D true
      MONITOR/MWAIT                           =3D true
      CPL-qualified debug store               =3D true
      VMX: virtual machine extensions         =3D true
      SMX: safer mode extensions              =3D false
      Enhanced Intel SpeedStep Technology     =3D true
      thermal monitor 2                       =3D true
      SSSE3 extensions                        =3D true
      context ID: adaptive or shared L1 data  =3D false
      FMA instruction                         =3D false
      CMPXCHG16B instruction                  =3D true
      xTPR disable                            =3D true
      perfmon and debug                       =3D true
      process context identifiers             =3D false
      direct cache access                     =3D false
      SSE4.1 extensions                       =3D false
      SSE4.2 extensions                       =3D false
      extended xAPIC support                  =3D false
      MOVBE instruction                       =3D true
      POPCNT instruction                      =3D false
      time stamp counter deadline             =3D false
      AES instruction                         =3D false
      XSAVE/XSTOR states                      =3D false
      OS-enabled XSAVE/XSTOR                  =3D false
      AVX: advanced vector extensions         =3D false
      F16C half-precision convert instruction =3D false
      RDRAND instruction                      =3D false
      hypervisor guest status                 =3D false
   cache and TLB information (2):
      0x59: data TLB: 4K pages, 16 entries
      0xba: data TLB: 4K, 4-way, 64 entries
      0x4f: instruction TLB: 4K pages, 32 entries
      0xc0: data TLB: 4K & 4M pages, 4-way, 8 entries
      0x80: L2 cache: 512K, 8-way, 64 byte lines
      0x30: L1 cache: 32K, 8-way, 64 byte lines
      0x0e: L1 data cache: 24K, 6-way, 64 byte lines
   processor serial number: 0003-0669-0000-0000-0000-0000
   deterministic cache parameters (4):
      --- cache 0 ---
      cache type                           =3D data cache (1)
      cache level                          =3D 0x1 (1)
      self-initializing cache level        =3D true
      fully associative cache              =3D false
      extra threads sharing this cache     =3D 0x1 (1)
      extra processor cores on this die    =3D 0x1 (1)
      system coherency line size           =3D 0x3f (63)
      physical line partitions             =3D 0x0 (0)
      ways of associativity                =3D 0x5 (5)
      WBINVD/INVD behavior on lower caches =3D true
      inclusive to lower caches            =3D false
      complex cache indexing               =3D false
      number of sets - 1 (s)               =3D 63
      --- cache 1 ---
      cache type                           =3D instruction cache (2)
      cache level                          =3D 0x1 (1)
      self-initializing cache level        =3D true
      fully associative cache              =3D false
      extra threads sharing this cache     =3D 0x1 (1)
      extra processor cores on this die    =3D 0x1 (1)
      system coherency line size           =3D 0x3f (63)
      physical line partitions             =3D 0x0 (0)
      ways of associativity                =3D 0x7 (7)
      WBINVD/INVD behavior on lower caches =3D true
      inclusive to lower caches            =3D false
      complex cache indexing               =3D false
      number of sets - 1 (s)               =3D 63
      --- cache 2 ---
      cache type                           =3D unified cache (3)
      cache level                          =3D 0x2 (2)
      self-initializing cache level        =3D true
      fully associative cache              =3D false
      extra threads sharing this cache     =3D 0x1 (1)
      extra processor cores on this die    =3D 0x1 (1)
      system coherency line size           =3D 0x3f (63)
      physical line partitions             =3D 0x0 (0)
      ways of associativity                =3D 0x7 (7)
      WBINVD/INVD behavior on lower caches =3D true
      inclusive to lower caches            =3D false
      complex cache indexing               =3D false
      number of sets - 1 (s)               =3D 1023
   MONITOR/MWAIT (5):
      smallest monitor-line size (bytes)       =3D 0x40 (64)
      largest monitor-line size (bytes)        =3D 0x40 (64)
      enum of Monitor-MWAIT exts supported     =3D true
      supports intrs as break-event for MWAIT  =3D true
      number of C0 sub C-states using MWAIT    =3D 0x0 (0)
      number of C1 sub C-states using MWAIT    =3D 0x2 (2)
      number of C2 sub C-states using MWAIT    =3D 0x2 (2)
      number of C3 sub C-states using MWAIT    =3D 0x0 (0)
      number of C4 sub C-states using MWAIT    =3D 0x2 (2)
      number of C5 sub C-states using MWAIT    =3D 0x0 (0)
      number of C6 sub C-states using MWAIT    =3D 0x3 (3)
      number of C7 sub C-states using MWAIT    =3D 0x0 (0)
   Thermal and Power Management Features (6):
      digital thermometer                     =3D true
      Intel Turbo Boost Technology            =3D false
      ARAT always running APIC timer          =3D true
      PLN power limit notification            =3D false
      ECMD extended clock modulation duty     =3D false
      PTM package thermal management          =3D false
      digital thermometer thresholds          =3D 0x2 (2)
      ACNT/MCNT supported performance measure =3D true
      ACNT2 available                         =3D false
      performance-energy bias capability      =3D false
   extended feature flags (7):
      FSGSBASE instructions                    =3D false
      IA32_TSC_ADJUST MSR supported            =3D false
      BMI instruction                          =3D false
      HLE hardware lock elision                =3D false
      AVX2: advanced vector extensions 2       =3D false
      SMEP supervisor mode exec protection     =3D false
      BMI2 instructions                        =3D false
      enhanced REP MOVSB/STOSB                 =3D false
      INVPCID instruction                      =3D false
      RTM: restricted transactional memory     =3D false
      QM: quality of service monitoring        =3D false
      deprecated FPU CS/DS                     =3D false
      intel memory protection extensions       =3D false
      AVX512F: AVX-512 foundation instructions =3D false
      RDSEED instruction                       =3D false
      ADX instructions                         =3D false
      SMAP: supervisor mode access prevention  =3D false
      Intel processor trace                    =3D false
      AVX512PF: prefetch instructions          =3D false
      AVX512ER: exponent & reciprocal instrs   =3D false
      AVX512CD: conflict detection instrs      =3D false
      SHA instructions                         =3D false
      PREFETCHWT1                              =3D false
   Direct Cache Access Parameters (9):
      PLATFORM_DCA_CAP MSR bits =3D 0
   Architecture Performance Monitoring Features (0xa/eax):
      version ID                               =3D 0x3 (3)
      number of counters per logical processor =3D 0x2 (2)
      bit width of counter                     =3D 0x28 (40)
      length of EBX bit vector                 =3D 0x7 (7)
   Architecture Performance Monitoring Features (0xa/ebx):
      core cycle event not available           =3D false
      instruction retired event not available  =3D false
      reference cycles event not available     =3D false
      last-level cache ref event not available =3D false
      last-level cache miss event not avail    =3D false
      branch inst retired event not available  =3D false
      branch mispred retired event not avail   =3D false
   Architecture Performance Monitoring Features (0xa/edx):
      number of fixed counters    =3D 0x3 (3)
      bit width of fixed counters =3D 0x28 (40)
   extended feature flags (0x80000001/edx):
      SYSCALL and SYSRET instructions        =3D true
      execution disable                      =3D true
      1-GB large page support                =3D false
      RDTSCP                                 =3D false
      64-bit extensions technology available =3D true
   Intel feature flags (0x80000001/ecx):
      LAHF/SAHF supported in 64-bit mode     =3D true
      LZCNT advanced bit manipulation        =3D false
      3DNow! PREFETCH/PREFETCHW instructions =3D false
   brand =3D "        Intel(R) Atom(TM) CPU S1260   @ 2.00GHz"
   L1 TLB/cache information: 2M/4M pages & L1 TLB (0x80000005/eax):
      instruction # entries     =3D 0x0 (0)
      instruction associativity =3D 0x0 (0)
      data # entries            =3D 0x0 (0)
      data associativity        =3D 0x0 (0)
   L1 TLB/cache information: 4K pages & L1 TLB (0x80000005/ebx):
      instruction # entries     =3D 0x0 (0)
      instruction associativity =3D 0x0 (0)
      data # entries            =3D 0x0 (0)
      data associativity        =3D 0x0 (0)
   L1 data cache information (0x80000005/ecx):
      line size (bytes) =3D 0x0 (0)
      lines per tag     =3D 0x0 (0)
      associativity     =3D 0x0 (0)
      size (Kb)         =3D 0x0 (0)
   L1 instruction cache information (0x80000005/edx):
      line size (bytes) =3D 0x0 (0)
      lines per tag     =3D 0x0 (0)
      associativity     =3D 0x0 (0)
      size (Kb)         =3D 0x0 (0)
   L2 TLB/cache information: 2M/4M pages & L2 TLB (0x80000006/eax):
      instruction # entries     =3D 0x0 (0)
      instruction associativity =3D L2 off (0)
      data # entries            =3D 0x0 (0)
      data associativity        =3D L2 off (0)
   L2 TLB/cache information: 4K pages & L2 TLB (0x80000006/ebx):
      instruction # entries     =3D 0x0 (0)
      instruction associativity =3D L2 off (0)
      data # entries            =3D 0x0 (0)
      data associativity        =3D L2 off (0)
   L2 unified cache information (0x80000006/ecx):
      line size (bytes) =3D 0x40 (64)
      lines per tag     =3D 0x0 (0)
      associativity     =3D 8-way (6)
      size (Kb)         =3D 0x200 (512)
   L3 cache information (0x80000006/edx):
      line size (bytes)     =3D 0x0 (0)
      lines per tag         =3D 0x0 (0)
      associativity         =3D L2 off (0)
      size (in 512Kb units) =3D 0x0 (0)
   Advanced Power Management Features (0x80000007/edx):
      temperature sensing diode      =3D false
      frequency ID (FID) control     =3D false
      voltage ID (VID) control       =3D false
      thermal trip (TTP)             =3D false
      thermal monitor (TM)           =3D false
      software thermal control (STC) =3D false
      100 MHz multiplier control     =3D false
      hardware P-State control       =3D false
      TscInvariant                   =3D true
   Physical Address and Linear Address Size (0x80000008/eax):
      maximum physical address bits         =3D 0x24 (36)
      maximum linear (virtual) address bits =3D 0x30 (48)
      maximum guest physical address bits   =3D 0x0 (0)
   Logical CPU cores (0x80000008/ecx):
      number of CPU cores - 1 =3D 0x0 (0)
      ApicIdCoreIdSize        =3D 0x0 (0)
   (multi-processing synth): multi-core (c=3D2), hyper-threaded (t=3D2)
   (multi-processing method): Intel leaf 1/4
   (APIC widths synth): CORE_width=3D1 SMT_width=3D1
   (APIC synth): PKG_ID=3D0 CORE_ID=3D0 SMT_ID=3D1
   (synth) =3D Intel Atom D2000/N2000 (Cedarview), 32nm
CPU 2:
   vendor_id =3D "GenuineIntel"
   version information (1/eax):
      processor type  =3D primary processor (0)
      family          =3D Intel Pentium Pro/II/III/Celeron/Core/Core =
2/Atom, AMD Athlon/Duron, Cyrix M2, VIA C3 (6)
      model           =3D 0x6 (6)
      stepping id     =3D 0x9 (9)
      extended family =3D 0x0 (0)
      extended model  =3D 0x3 (3)
      (simple synth)  =3D Intel Atom D2000/N2000 (Cedarview), 32nm
   miscellaneous (1/ebx):
      process local APIC physical ID =3D 0x2 (2)
      cpu count                      =3D 0x4 (4)
      CLFLUSH line size              =3D 0x8 (8)
      brand index                    =3D 0x0 (0)
   brand id =3D 0x00 (0): unknown
   feature information (1/edx):
      x87 FPU on chip                        =3D true
      virtual-8086 mode enhancement          =3D true
      debugging extensions                   =3D true
      page size extensions                   =3D true
      time stamp counter                     =3D true
      RDMSR and WRMSR support                =3D true
      physical address extensions            =3D true
      machine check exception                =3D true
      CMPXCHG8B inst.                        =3D true
      APIC on chip                           =3D true
      SYSENTER and SYSEXIT                   =3D true
      memory type range registers            =3D true
      PTE global bit                         =3D true
      machine check architecture             =3D true
      conditional move/compare instruction   =3D true
      page attribute table                   =3D true
      page size extension                    =3D true
      processor serial number                =3D false
      CLFLUSH instruction                    =3D true
      debug store                            =3D true
      thermal monitor and clock ctrl         =3D true
      MMX Technology                         =3D true
      FXSAVE/FXRSTOR                         =3D true
      SSE extensions                         =3D true
      SSE2 extensions                        =3D true
      self snoop                             =3D true
      hyper-threading / multi-core supported =3D true
      therm. monitor                         =3D true
      IA64                                   =3D false
      pending break event                    =3D true
   feature information (1/ecx):
      PNI/SSE3: Prescott New Instructions     =3D true
      PCLMULDQ instruction                    =3D false
      64-bit debug store                      =3D true
      MONITOR/MWAIT                           =3D true
      CPL-qualified debug store               =3D true
      VMX: virtual machine extensions         =3D true
      SMX: safer mode extensions              =3D false
      Enhanced Intel SpeedStep Technology     =3D true
      thermal monitor 2                       =3D true
      SSSE3 extensions                        =3D true
      context ID: adaptive or shared L1 data  =3D false
      FMA instruction                         =3D false
      CMPXCHG16B instruction                  =3D true
      xTPR disable                            =3D true
      perfmon and debug                       =3D true
      process context identifiers             =3D false
      direct cache access                     =3D false
      SSE4.1 extensions                       =3D false
      SSE4.2 extensions                       =3D false
      extended xAPIC support                  =3D false
      MOVBE instruction                       =3D true
      POPCNT instruction                      =3D false
      time stamp counter deadline             =3D false
      AES instruction                         =3D false
      XSAVE/XSTOR states                      =3D false
      OS-enabled XSAVE/XSTOR                  =3D false
      AVX: advanced vector extensions         =3D false
      F16C half-precision convert instruction =3D false
      RDRAND instruction                      =3D false
      hypervisor guest status                 =3D false
   cache and TLB information (2):
      0x59: data TLB: 4K pages, 16 entries
      0xba: data TLB: 4K, 4-way, 64 entries
      0x4f: instruction TLB: 4K pages, 32 entries
      0xc0: data TLB: 4K & 4M pages, 4-way, 8 entries
      0x80: L2 cache: 512K, 8-way, 64 byte lines
      0x30: L1 cache: 32K, 8-way, 64 byte lines
      0x0e: L1 data cache: 24K, 6-way, 64 byte lines
   processor serial number: 0003-0669-0000-0000-0000-0000
   deterministic cache parameters (4):
      --- cache 0 ---
      cache type                           =3D data cache (1)
      cache level                          =3D 0x1 (1)
      self-initializing cache level        =3D true
      fully associative cache              =3D false
      extra threads sharing this cache     =3D 0x1 (1)
      extra processor cores on this die    =3D 0x1 (1)
      system coherency line size           =3D 0x3f (63)
      physical line partitions             =3D 0x0 (0)
      ways of associativity                =3D 0x5 (5)
      WBINVD/INVD behavior on lower caches =3D true
      inclusive to lower caches            =3D false
      complex cache indexing               =3D false
      number of sets - 1 (s)               =3D 63
      --- cache 1 ---
      cache type                           =3D instruction cache (2)
      cache level                          =3D 0x1 (1)
      self-initializing cache level        =3D true
      fully associative cache              =3D false
      extra threads sharing this cache     =3D 0x1 (1)
      extra processor cores on this die    =3D 0x1 (1)
      system coherency line size           =3D 0x3f (63)
      physical line partitions             =3D 0x0 (0)
      ways of associativity                =3D 0x7 (7)
      WBINVD/INVD behavior on lower caches =3D true
      inclusive to lower caches            =3D false
      complex cache indexing               =3D false
      number of sets - 1 (s)               =3D 63
      --- cache 2 ---
      cache type                           =3D unified cache (3)
      cache level                          =3D 0x2 (2)
      self-initializing cache level        =3D true
      fully associative cache              =3D false
      extra threads sharing this cache     =3D 0x1 (1)
      extra processor cores on this die    =3D 0x1 (1)
      system coherency line size           =3D 0x3f (63)
      physical line partitions             =3D 0x0 (0)
      ways of associativity                =3D 0x7 (7)
      WBINVD/INVD behavior on lower caches =3D true
      inclusive to lower caches            =3D false
      complex cache indexing               =3D false
      number of sets - 1 (s)               =3D 1023
   MONITOR/MWAIT (5):
      smallest monitor-line size (bytes)       =3D 0x40 (64)
      largest monitor-line size (bytes)        =3D 0x40 (64)
      enum of Monitor-MWAIT exts supported     =3D true
      supports intrs as break-event for MWAIT  =3D true
      number of C0 sub C-states using MWAIT    =3D 0x0 (0)
      number of C1 sub C-states using MWAIT    =3D 0x2 (2)
      number of C2 sub C-states using MWAIT    =3D 0x2 (2)
      number of C3 sub C-states using MWAIT    =3D 0x0 (0)
      number of C4 sub C-states using MWAIT    =3D 0x2 (2)
      number of C5 sub C-states using MWAIT    =3D 0x0 (0)
      number of C6 sub C-states using MWAIT    =3D 0x3 (3)
      number of C7 sub C-states using MWAIT    =3D 0x0 (0)
   Thermal and Power Management Features (6):
      digital thermometer                     =3D true
      Intel Turbo Boost Technology            =3D false
      ARAT always running APIC timer          =3D true
      PLN power limit notification            =3D false
      ECMD extended clock modulation duty     =3D false
      PTM package thermal management          =3D false
      digital thermometer thresholds          =3D 0x2 (2)
      ACNT/MCNT supported performance measure =3D true
      ACNT2 available                         =3D false
      performance-energy bias capability      =3D false
   extended feature flags (7):
      FSGSBASE instructions                    =3D false
      IA32_TSC_ADJUST MSR supported            =3D false
      BMI instruction                          =3D false
      HLE hardware lock elision                =3D false
      AVX2: advanced vector extensions 2       =3D false
      SMEP supervisor mode exec protection     =3D false
      BMI2 instructions                        =3D false
      enhanced REP MOVSB/STOSB                 =3D false
      INVPCID instruction                      =3D false
      RTM: restricted transactional memory     =3D false
      QM: quality of service monitoring        =3D false
      deprecated FPU CS/DS                     =3D false
      intel memory protection extensions       =3D false
      AVX512F: AVX-512 foundation instructions =3D false
      RDSEED instruction                       =3D false
      ADX instructions                         =3D false
      SMAP: supervisor mode access prevention  =3D false
      Intel processor trace                    =3D false
      AVX512PF: prefetch instructions          =3D false
      AVX512ER: exponent & reciprocal instrs   =3D false
      AVX512CD: conflict detection instrs      =3D false
      SHA instructions                         =3D false
      PREFETCHWT1                              =3D false
   Direct Cache Access Parameters (9):
      PLATFORM_DCA_CAP MSR bits =3D 0
   Architecture Performance Monitoring Features (0xa/eax):
      version ID                               =3D 0x3 (3)
      number of counters per logical processor =3D 0x2 (2)
      bit width of counter                     =3D 0x28 (40)
      length of EBX bit vector                 =3D 0x7 (7)
   Architecture Performance Monitoring Features (0xa/ebx):
      core cycle event not available           =3D false
      instruction retired event not available  =3D false
      reference cycles event not available     =3D false
      last-level cache ref event not available =3D false
      last-level cache miss event not avail    =3D false
      branch inst retired event not available  =3D false
      branch mispred retired event not avail   =3D false
   Architecture Performance Monitoring Features (0xa/edx):
      number of fixed counters    =3D 0x3 (3)
      bit width of fixed counters =3D 0x28 (40)
   extended feature flags (0x80000001/edx):
      SYSCALL and SYSRET instructions        =3D true
      execution disable                      =3D true
      1-GB large page support                =3D false
      RDTSCP                                 =3D false
      64-bit extensions technology available =3D true
   Intel feature flags (0x80000001/ecx):
      LAHF/SAHF supported in 64-bit mode     =3D true
      LZCNT advanced bit manipulation        =3D false
      3DNow! PREFETCH/PREFETCHW instructions =3D false
   brand =3D "        Intel(R) Atom(TM) CPU S1260   @ 2.00GHz"
   L1 TLB/cache information: 2M/4M pages & L1 TLB (0x80000005/eax):
      instruction # entries     =3D 0x0 (0)
      instruction associativity =3D 0x0 (0)
      data # entries            =3D 0x0 (0)
      data associativity        =3D 0x0 (0)
   L1 TLB/cache information: 4K pages & L1 TLB (0x80000005/ebx):
      instruction # entries     =3D 0x0 (0)
      instruction associativity =3D 0x0 (0)
      data # entries            =3D 0x0 (0)
      data associativity        =3D 0x0 (0)
   L1 data cache information (0x80000005/ecx):
      line size (bytes) =3D 0x0 (0)
      lines per tag     =3D 0x0 (0)
      associativity     =3D 0x0 (0)
      size (Kb)         =3D 0x0 (0)
   L1 instruction cache information (0x80000005/edx):
      line size (bytes) =3D 0x0 (0)
      lines per tag     =3D 0x0 (0)
      associativity     =3D 0x0 (0)
      size (Kb)         =3D 0x0 (0)
   L2 TLB/cache information: 2M/4M pages & L2 TLB (0x80000006/eax):
      instruction # entries     =3D 0x0 (0)
      instruction associativity =3D L2 off (0)
      data # entries            =3D 0x0 (0)
      data associativity        =3D L2 off (0)
   L2 TLB/cache information: 4K pages & L2 TLB (0x80000006/ebx):
      instruction # entries     =3D 0x0 (0)
      instruction associativity =3D L2 off (0)
      data # entries            =3D 0x0 (0)
      data associativity        =3D L2 off (0)
   L2 unified cache information (0x80000006/ecx):
      line size (bytes) =3D 0x40 (64)
      lines per tag     =3D 0x0 (0)
      associativity     =3D 8-way (6)
      size (Kb)         =3D 0x200 (512)
   L3 cache information (0x80000006/edx):
      line size (bytes)     =3D 0x0 (0)
      lines per tag         =3D 0x0 (0)
      associativity         =3D L2 off (0)
      size (in 512Kb units) =3D 0x0 (0)
   Advanced Power Management Features (0x80000007/edx):
      temperature sensing diode      =3D false
      frequency ID (FID) control     =3D false
      voltage ID (VID) control       =3D false
      thermal trip (TTP)             =3D false
      thermal monitor (TM)           =3D false
      software thermal control (STC) =3D false
      100 MHz multiplier control     =3D false
      hardware P-State control       =3D false
      TscInvariant                   =3D true
   Physical Address and Linear Address Size (0x80000008/eax):
      maximum physical address bits         =3D 0x24 (36)
      maximum linear (virtual) address bits =3D 0x30 (48)
      maximum guest physical address bits   =3D 0x0 (0)
   Logical CPU cores (0x80000008/ecx):
      number of CPU cores - 1 =3D 0x0 (0)
      ApicIdCoreIdSize        =3D 0x0 (0)
   (multi-processing synth): multi-core (c=3D2), hyper-threaded (t=3D2)
   (multi-processing method): Intel leaf 1/4
   (APIC widths synth): CORE_width=3D1 SMT_width=3D1
   (APIC synth): PKG_ID=3D0 CORE_ID=3D1 SMT_ID=3D0
   (synth) =3D Intel Atom D2000/N2000 (Cedarview), 32nm
CPU 3:
   vendor_id =3D "GenuineIntel"
   version information (1/eax):
      processor type  =3D primary processor (0)
      family          =3D Intel Pentium Pro/II/III/Celeron/Core/Core =
2/Atom, AMD Athlon/Duron, Cyrix M2, VIA C3 (6)
      model           =3D 0x6 (6)
      stepping id     =3D 0x9 (9)
      extended family =3D 0x0 (0)
      extended model  =3D 0x3 (3)
      (simple synth)  =3D Intel Atom D2000/N2000 (Cedarview), 32nm
   miscellaneous (1/ebx):
      process local APIC physical ID =3D 0x3 (3)
      cpu count                      =3D 0x4 (4)
      CLFLUSH line size              =3D 0x8 (8)
      brand index                    =3D 0x0 (0)
   brand id =3D 0x00 (0): unknown
   feature information (1/edx):
      x87 FPU on chip                        =3D true
      virtual-8086 mode enhancement          =3D true
      debugging extensions                   =3D true
      page size extensions                   =3D true
      time stamp counter                     =3D true
      RDMSR and WRMSR support                =3D true
      physical address extensions            =3D true
      machine check exception                =3D true
      CMPXCHG8B inst.                        =3D true
      APIC on chip                           =3D true
      SYSENTER and SYSEXIT                   =3D true
      memory type range registers            =3D true
      PTE global bit                         =3D true
      machine check architecture             =3D true
      conditional move/compare instruction   =3D true
      page attribute table                   =3D true
      page size extension                    =3D true
      processor serial number                =3D false
      CLFLUSH instruction                    =3D true
      debug store                            =3D true
      thermal monitor and clock ctrl         =3D true
      MMX Technology                         =3D true
      FXSAVE/FXRSTOR                         =3D true
      SSE extensions                         =3D true
      SSE2 extensions                        =3D true
      self snoop                             =3D true
      hyper-threading / multi-core supported =3D true
      therm. monitor                         =3D true
      IA64                                   =3D false
      pending break event                    =3D true
   feature information (1/ecx):
      PNI/SSE3: Prescott New Instructions     =3D true
      PCLMULDQ instruction                    =3D false
      64-bit debug store                      =3D true
      MONITOR/MWAIT                           =3D true
      CPL-qualified debug store               =3D true
      VMX: virtual machine extensions         =3D true
      SMX: safer mode extensions              =3D false
      Enhanced Intel SpeedStep Technology     =3D true
      thermal monitor 2                       =3D true
      SSSE3 extensions                        =3D true
      context ID: adaptive or shared L1 data  =3D false
      FMA instruction                         =3D false
      CMPXCHG16B instruction                  =3D true
      xTPR disable                            =3D true
      perfmon and debug                       =3D true
      process context identifiers             =3D false
      direct cache access                     =3D false
      SSE4.1 extensions                       =3D false
      SSE4.2 extensions                       =3D false
      extended xAPIC support                  =3D false
      MOVBE instruction                       =3D true
      POPCNT instruction                      =3D false
      time stamp counter deadline             =3D false
      AES instruction                         =3D false
      XSAVE/XSTOR states                      =3D false
      OS-enabled XSAVE/XSTOR                  =3D false
      AVX: advanced vector extensions         =3D false
      F16C half-precision convert instruction =3D false
      RDRAND instruction                      =3D false
      hypervisor guest status                 =3D false
   cache and TLB information (2):
      0x59: data TLB: 4K pages, 16 entries
      0xba: data TLB: 4K, 4-way, 64 entries
      0x4f: instruction TLB: 4K pages, 32 entries
      0xc0: data TLB: 4K & 4M pages, 4-way, 8 entries
      0x80: L2 cache: 512K, 8-way, 64 byte lines
      0x30: L1 cache: 32K, 8-way, 64 byte lines
      0x0e: L1 data cache: 24K, 6-way, 64 byte lines
   processor serial number: 0003-0669-0000-0000-0000-0000
   deterministic cache parameters (4):
      --- cache 0 ---
      cache type                           =3D data cache (1)
      cache level                          =3D 0x1 (1)
      self-initializing cache level        =3D true
      fully associative cache              =3D false
      extra threads sharing this cache     =3D 0x1 (1)
      extra processor cores on this die    =3D 0x1 (1)
      system coherency line size           =3D 0x3f (63)
      physical line partitions             =3D 0x0 (0)
      ways of associativity                =3D 0x5 (5)
      WBINVD/INVD behavior on lower caches =3D true
      inclusive to lower caches            =3D false
      complex cache indexing               =3D false
      number of sets - 1 (s)               =3D 63
      --- cache 1 ---
      cache type                           =3D instruction cache (2)
      cache level                          =3D 0x1 (1)
      self-initializing cache level        =3D true
      fully associative cache              =3D false
      extra threads sharing this cache     =3D 0x1 (1)
      extra processor cores on this die    =3D 0x1 (1)
      system coherency line size           =3D 0x3f (63)
      physical line partitions             =3D 0x0 (0)
      ways of associativity                =3D 0x7 (7)
      WBINVD/INVD behavior on lower caches =3D true
      inclusive to lower caches            =3D false
      complex cache indexing               =3D false
      number of sets - 1 (s)               =3D 63
      --- cache 2 ---
      cache type                           =3D unified cache (3)
      cache level                          =3D 0x2 (2)
      self-initializing cache level        =3D true
      fully associative cache              =3D false
      extra threads sharing this cache     =3D 0x1 (1)
      extra processor cores on this die    =3D 0x1 (1)
      system coherency line size           =3D 0x3f (63)
      physical line partitions             =3D 0x0 (0)
      ways of associativity                =3D 0x7 (7)
      WBINVD/INVD behavior on lower caches =3D true
      inclusive to lower caches            =3D false
      complex cache indexing               =3D false
      number of sets - 1 (s)               =3D 1023
   MONITOR/MWAIT (5):
      smallest monitor-line size (bytes)       =3D 0x40 (64)
      largest monitor-line size (bytes)        =3D 0x40 (64)
      enum of Monitor-MWAIT exts supported     =3D true
      supports intrs as break-event for MWAIT  =3D true
      number of C0 sub C-states using MWAIT    =3D 0x0 (0)
      number of C1 sub C-states using MWAIT    =3D 0x2 (2)
      number of C2 sub C-states using MWAIT    =3D 0x2 (2)
      number of C3 sub C-states using MWAIT    =3D 0x0 (0)
      number of C4 sub C-states using MWAIT    =3D 0x2 (2)
      number of C5 sub C-states using MWAIT    =3D 0x0 (0)
      number of C6 sub C-states using MWAIT    =3D 0x3 (3)
      number of C7 sub C-states using MWAIT    =3D 0x0 (0)
   Thermal and Power Management Features (6):
      digital thermometer                     =3D true
      Intel Turbo Boost Technology            =3D false
      ARAT always running APIC timer          =3D true
      PLN power limit notification            =3D false
      ECMD extended clock modulation duty     =3D false
      PTM package thermal management          =3D false
      digital thermometer thresholds          =3D 0x2 (2)
      ACNT/MCNT supported performance measure =3D true
      ACNT2 available                         =3D false
      performance-energy bias capability      =3D false
   extended feature flags (7):
      FSGSBASE instructions                    =3D false
      IA32_TSC_ADJUST MSR supported            =3D false
      BMI instruction                          =3D false
      HLE hardware lock elision                =3D false
      AVX2: advanced vector extensions 2       =3D false
      SMEP supervisor mode exec protection     =3D false
      BMI2 instructions                        =3D false
      enhanced REP MOVSB/STOSB                 =3D false
      INVPCID instruction                      =3D false
      RTM: restricted transactional memory     =3D false
      QM: quality of service monitoring        =3D false
      deprecated FPU CS/DS                     =3D false
      intel memory protection extensions       =3D false
      AVX512F: AVX-512 foundation instructions =3D false
      RDSEED instruction                       =3D false
      ADX instructions                         =3D false
      SMAP: supervisor mode access prevention  =3D false
      Intel processor trace                    =3D false
      AVX512PF: prefetch instructions          =3D false
      AVX512ER: exponent & reciprocal instrs   =3D false
      AVX512CD: conflict detection instrs      =3D false
      SHA instructions                         =3D false
      PREFETCHWT1                              =3D false
   Direct Cache Access Parameters (9):
      PLATFORM_DCA_CAP MSR bits =3D 0
   Architecture Performance Monitoring Features (0xa/eax):
      version ID                               =3D 0x3 (3)
      number of counters per logical processor =3D 0x2 (2)
      bit width of counter                     =3D 0x28 (40)
      length of EBX bit vector                 =3D 0x7 (7)
   Architecture Performance Monitoring Features (0xa/ebx):
      core cycle event not available           =3D false
      instruction retired event not available  =3D false
      reference cycles event not available     =3D false
      last-level cache ref event not available =3D false
      last-level cache miss event not avail    =3D false
      branch inst retired event not available  =3D false
      branch mispred retired event not avail   =3D false
   Architecture Performance Monitoring Features (0xa/edx):
      number of fixed counters    =3D 0x3 (3)
      bit width of fixed counters =3D 0x28 (40)
   extended feature flags (0x80000001/edx):
      SYSCALL and SYSRET instructions        =3D true
      execution disable                      =3D true
      1-GB large page support                =3D false
      RDTSCP                                 =3D false
      64-bit extensions technology available =3D true
   Intel feature flags (0x80000001/ecx):
      LAHF/SAHF supported in 64-bit mode     =3D true
      LZCNT advanced bit manipulation        =3D false
      3DNow! PREFETCH/PREFETCHW instructions =3D false
   brand =3D "        Intel(R) Atom(TM) CPU S1260   @ 2.00GHz"
   L1 TLB/cache information: 2M/4M pages & L1 TLB (0x80000005/eax):
      instruction # entries     =3D 0x0 (0)
      instruction associativity =3D 0x0 (0)
      data # entries            =3D 0x0 (0)
      data associativity        =3D 0x0 (0)
   L1 TLB/cache information: 4K pages & L1 TLB (0x80000005/ebx):
      instruction # entries     =3D 0x0 (0)
      instruction associativity =3D 0x0 (0)
      data # entries            =3D 0x0 (0)
      data associativity        =3D 0x0 (0)
   L1 data cache information (0x80000005/ecx):
      line size (bytes) =3D 0x0 (0)
      lines per tag     =3D 0x0 (0)
      associativity     =3D 0x0 (0)
      size (Kb)         =3D 0x0 (0)
   L1 instruction cache information (0x80000005/edx):
      line size (bytes) =3D 0x0 (0)
      lines per tag     =3D 0x0 (0)
      associativity     =3D 0x0 (0)
      size (Kb)         =3D 0x0 (0)
   L2 TLB/cache information: 2M/4M pages & L2 TLB (0x80000006/eax):
      instruction # entries     =3D 0x0 (0)
      instruction associativity =3D L2 off (0)
      data # entries            =3D 0x0 (0)
      data associativity        =3D L2 off (0)
   L2 TLB/cache information: 4K pages & L2 TLB (0x80000006/ebx):
      instruction # entries     =3D 0x0 (0)
      instruction associativity =3D L2 off (0)
      data # entries            =3D 0x0 (0)
      data associativity        =3D L2 off (0)
   L2 unified cache information (0x80000006/ecx):
      line size (bytes) =3D 0x40 (64)
      lines per tag     =3D 0x0 (0)
      associativity     =3D 8-way (6)
      size (Kb)         =3D 0x200 (512)
   L3 cache information (0x80000006/edx):
      line size (bytes)     =3D 0x0 (0)
      lines per tag         =3D 0x0 (0)
      associativity         =3D L2 off (0)
      size (in 512Kb units) =3D 0x0 (0)
   Advanced Power Management Features (0x80000007/edx):
      temperature sensing diode      =3D false
      frequency ID (FID) control     =3D false
      voltage ID (VID) control       =3D false
      thermal trip (TTP)             =3D false
      thermal monitor (TM)           =3D false
      software thermal control (STC) =3D false
      100 MHz multiplier control     =3D false
      hardware P-State control       =3D false
      TscInvariant                   =3D true
   Physical Address and Linear Address Size (0x80000008/eax):
      maximum physical address bits         =3D 0x24 (36)
      maximum linear (virtual) address bits =3D 0x30 (48)
      maximum guest physical address bits   =3D 0x0 (0)
   Logical CPU cores (0x80000008/ecx):
      number of CPU cores - 1 =3D 0x0 (0)
      ApicIdCoreIdSize        =3D 0x0 (0)
   (multi-processing synth): multi-core (c=3D2), hyper-threaded (t=3D2)
   (multi-processing method): Intel leaf 1/4
   (APIC widths synth): CORE_width=3D1 SMT_width=3D1
   (APIC synth): PKG_ID=3D0 CORE_ID=3D1 SMT_ID=3D1
   (synth) =3D Intel Atom D2000/N2000 (Cedarview), 32nm

--Apple-Mail=_C42D8B43-6B56-42E2-8A59-FDDE90B77C47
Content-Disposition: attachment;
	filename=cpuinfo.txt
Content-Type: text/plain;
	name="cpuinfo.txt"
Content-Transfer-Encoding: quoted-printable

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 54
model name	: Intel(R) Atom(TM) CPU S1260   @ 2.00GHz
stepping	: 9
microcode	: 0x10d
cpu MHz		: 600.000
cache size	: 512 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 2
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge =
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe =
syscall nx lm constant_tsc arch_perfmon pebs bts rep_good nopl =
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 =
xtpr pdcm movbe lahf_lm arat dtherm tpr_shadow vnmi flexpriority
bogomips	: 3990.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 54
model name	: Intel(R) Atom(TM) CPU S1260   @ 2.00GHz
stepping	: 9
microcode	: 0x10d
cpu MHz		: 600.000
cache size	: 512 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 2
apicid		: 1
initial apicid	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge =
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe =
syscall nx lm constant_tsc arch_perfmon pebs bts rep_good nopl =
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 =
xtpr pdcm movbe lahf_lm arat dtherm tpr_shadow vnmi flexpriority
bogomips	: 3990.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 6
model		: 54
model name	: Intel(R) Atom(TM) CPU S1260   @ 2.00GHz
stepping	: 9
microcode	: 0x10d
cpu MHz		: 600.000
cache size	: 512 KB
physical id	: 0
siblings	: 4
core id		: 1
cpu cores	: 2
apicid		: 2
initial apicid	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge =
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe =
syscall nx lm constant_tsc arch_perfmon pebs bts rep_good nopl =
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 =
xtpr pdcm movbe lahf_lm arat dtherm tpr_shadow vnmi flexpriority
bogomips	: 3990.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 54
model name	: Intel(R) Atom(TM) CPU S1260   @ 2.00GHz
stepping	: 9
microcode	: 0x10d
cpu MHz		: 600.000
cache size	: 512 KB
physical id	: 0
siblings	: 4
core id		: 1
cpu cores	: 2
apicid		: 3
initial apicid	: 3
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge =
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe =
syscall nx lm constant_tsc arch_perfmon pebs bts rep_good nopl =
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 =
xtpr pdcm movbe lahf_lm arat dtherm tpr_shadow vnmi flexpriority
bogomips	: 3990.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:


--Apple-Mail=_C42D8B43-6B56-42E2-8A59-FDDE90B77C47
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=iso-8859-1


Am 30.09.2014 um 07:56 schrieb Jan Kiszka <jan.kiszka@siemens.com>:

> On 2014-09-30 02:13, Ben Hutchings wrote:
>> On Mon, 2014-09-29 at 11:57 +0200, Christophe Thil wrote:
>>> Package: src:linux
>>> Version: 3.16.3-2
>>> Severity: normal
>>>=20
>>> Dear Maintainer,
>>>=20
>>> with Kernel 3.16, intel_idle is enabled for the Intel Atom S1260 CPU
>>> (Centerton SoC). This leads to a +20=B0C temperature increase when =
the CPU
>>> is idle, exceeding the 100=B0C alarm threshold for passive cooled =
systems
>>> like the Supermicro X9SBAA-F.
>>>=20
>>> With 3.14, intel_idle was blacklisted for this CPU, which runs fine. =
If
>>> 3.16 is booted with intel_idle.max_cstate=3D0 =
processor.max_cstate=3D0,
>>> which disables the intel_idle, the CPU also stays cool.
>> [...]
>>=20
>> It looks like the relevant change is:
>>=20
>> commit acead1b0fac5b10d0ae3f1cc5f7820b9f9f924f5
>> Author: Jan Kiszka <jan.kiszka@siemens.com>
>> Date:   Sat Jan 25 22:24:22 2014 +0100
>>=20
>>    intel_idle: Add CPU model 54 (Atom N2000 series)
>>=20
>>    Add CPU ID for Atom N2600/N2800 processors. Datasheets indicate =
support
>>    for this, detailed information about potential quirks or =
limitations are
>>    missing, though. So we just reuse the definition for the previous =
ATOM
>>    series. [...]
>>=20
>> as those processors are part of the same Atom generation as =
Centerton.
>>=20
>> I think that more specific ID matching is required here.
>=20
> Hmm, I would check first if the Centerton series really has the same
> model ID (0x36) as the Cedarview. If they do, what other means of
> differentiation do we have?
>=20
> Jan
>=20
> --=20
> Siemens AG, Corporate Technology, CT RTC ITP SES-DE
> Corporate Competence Center Embedded Linux


--Apple-Mail=_C42D8B43-6B56-42E2-8A59-FDDE90B77C47--

--Apple-Mail=_A90CDE06-7B29-4DD8-AD82-2EC6FF736A81
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIQPjCCBTow
ggQioAMCAQICEArudgyN1w3zVorGnLkGaowwDQYJKoZIhvcNAQEFBQAwgfkxCzAJBgNVBAYTAkRF
MSkwJwYDVQQKEyBEZXV0c2NoZXIgU3Bhcmthc3NlbiBWZXJsYWcgR21iSDEfMB0GA1UECxMWVmVy
aVNpZ24gVHJ1c3QgTmV0d29yazE5MDcGA1UECxMwVGVybXMgb2YgdXNlIGF0IGh0dHBzOi8vd3d3
LnMtdHJ1c3QuZGUvcnBhIChjKTExMTUwMwYDVQQLEyxDbGFzcyAxIE1hbmFnZWQgUEtJIEluZGl2
aWR1YWwgU3Vic2NyaWJlciBDQTEsMCoGA1UEAxMjUy1UUlVTVCBDbGFzcyAxIENBIC0gU2ljaGVy
ZSBFLU1haWwwHhcNMTQwMjA2MDAwMDAwWhcNMTYwMjA2MjM1OTU5WjCByDEpMCcGA1UEChQgRGV1
dHNjaGVyIFNwYXJrYXNzZW4gVmVybGFnIEdtYkgxFjAUBgNVBAsUDVNpY2hlcmUgRU1haWwxRjBE
BgNVBAsTPXd3dy52ZXJpc2lnbi5jb20vcmVwb3NpdG9yeS9DUFMgSW5jb3JwLiBieSBSZWYuLExJ
QUIuTFREKGMpOTYxGDAWBgNVBAMMD0NocmlzdG9waGUgVGhpbDEhMB8GCSqGSIb3DQEJARYSY2hy
aXN0b3BoZUB0aGlsLmRlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuEblWNpMEEPP
Z+y9DzUr+tArD/zWVzEzLWgBcTZlfB7dY7Zl/nEpQVcvtQl3dRAbcfHkJuMkLXhYQRw9cm2Y5xZb
USHY2/4PFn8U73t6LwWtH9460chqhBYP7XUKkprzBFMq7iURXhaasjxuqr4vfZgNFAD6G46YeZPM
jVk+27E7bpZxFzDIYiK3zegkdLyyw3HFMGFm9QunuQDzxw5xUIOmpYAUnS5bL82ZzCbnLaguE6HY
DHqtcVGt0Q2OWMMhOxkS/7Z+hEczOI/SpDZCks5zJTU63vENsMTg3PFgt84/A01lU7hcwaGdvRnp
KMFp+4NtE8X6qaAKtUwwuV1RdwIDAQABo4HsMIHpMAkGA1UdEwQCMAAwZQYDVR0fBF4wXDBaoFig
VoZUaHR0cDovL29uc2l0ZWNybC5zLXRydXN0LmRlLy9EZXV0c2NoZXJTcGFya2Fzc2VuVmVybGFn
R21iSFNpY2hlcmVFTWFpbC9MYXRlc3RDUkwuY3JsMAsGA1UdDwQEAwIFoDBCBgNVHSAEOzA5MDcG
C2CGSAGG+EUBBxcBMCgwJgYIKwYBBQUHAgEWGmh0dHBzOi8vd3d3LnMtdHJ1c3QuZGUvcnBhMBEG
CWCGSAGG+EIBAQQEAwIHgDARBgpghkgBhvhFAQYJBAMBAf8wDQYJKoZIhvcNAQEFBQADggEBAI8u
ONu8/S0kNsSzYu7zt4n/sl/YotH1wWFUJaJqF9QQcYXgHHd6rh79PYuEa6bSgtUGLnNVv2XxhOUy
pUz+9VQNU8q7NvlnbkkWezMEmFnS5RcsEM+MMWbYxND7wsYTDvrw5K5AajxkYzpk2eNTY3QVtDsE
7yW7jRm8gzoIRPdVjz7qN2AB02QNcHhj+wqGcwuXnzUJrbDM8RtwYdv0PIH8CZbyvcORcYTBEcsh
2l+xUnIM3CXrYEs5eDLehOzhS0u8Uc5wRD1Rx9tMoPpVd6lthb1CZly65nUZQVlSOeGGbthHQVPL
H2K7m1e1rKGWVe2EVGYqTxP9z1RwDqtl1sIwggVzMIIEW6ADAgECAhA8IXF0NGkjrCzc9Gprk2l0
MA0GCSqGSIb3DQEBBQUAMHsxCzAJBgNVBAYTAkRFMSkwJwYDVQQKEyBEZXV0c2NoZXIgU3Bhcmth
c3NlbiBWZXJsYWcgR21iSDEfMB0GA1UECxMWVmVyaVNpZ24gVHJ1c3QgTmV0d29yazEgMB4GA1UE
AxMXUy1UUlVTVCBDbGFzcyAxIENBIC0gRzEwHhcNMTEwMzMxMDAwMDAwWhcNMTYwMzMwMjM1OTU5
WjCB+TELMAkGA1UEBhMCREUxKTAnBgNVBAoTIERldXRzY2hlciBTcGFya2Fzc2VuIFZlcmxhZyBH
bWJIMR8wHQYDVQQLExZWZXJpU2lnbiBUcnVzdCBOZXR3b3JrMTkwNwYDVQQLEzBUZXJtcyBvZiB1
c2UgYXQgaHR0cHM6Ly93d3cucy10cnVzdC5kZS9ycGEgKGMpMTExNTAzBgNVBAsTLENsYXNzIDEg
TWFuYWdlZCBQS0kgSW5kaXZpZHVhbCBTdWJzY3JpYmVyIENBMSwwKgYDVQQDEyNTLVRSVVNUIENs
YXNzIDEgQ0EgLSBTaWNoZXJlIEUtTWFpbDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
AL9NRLN+7qTh+EN5cEWg4WPi+Ps2SxeFA/Erx+PU6syr48ZBBV+5IcX+JReXwNf1bngNjfw1iEI6
Hv1J2hJXuvdbuKHhUO+3GL4SHIP7IS2j4nCEk4CrqzJGEW1SKDNnlOBbE75YaaKIxVJa0crMAi1c
F5h+x2cRPSfvdLoKB4uK9Fup3rbTZ3dppIEWEHr1WMpCtmDXPcMLBkJhu461re2+o2puOsDeu0MG
BQQNGN/s8GqNlrRlq/p7M5xUqVY4ttQ42rr4sEcDyEmFdYuxtBl9O+pPfaOg+KWqbUxRj2wtk9MG
LXtCkDLBtEBAUbouDAST+uM/lupyALVpF/3TNC0CAwEAAaOCAXIwggFuMBIGA1UdEwEB/wQIMAYB
Af8CAQAwbAYDVR0gBGUwYzBhBgtghkgBhvhFAQcXATBSMCYGCCsGAQUFBwIBFhpodHRwczovL3d3
dy5zLXRydXN0LmRlL2NwczAoBggrBgEFBQcCAjAcGhpodHRwczovL3d3dy5zLXRydXN0LmRlL3Jw
YTBzBgNVHR8EbDBqMGigZqBkhmJodHRwOi8vb25zaXRlY3JsLnMtdHJ1c3QuZGUvb2ZmbGluZUNB
L0RldXRzY2hlclNwYXJrYXNzZW5WZXJsYWdHbWJIU1RSVVNUQ2xhc3MxQ0EtRzEvTGF0ZXN0Q1JM
LmNybDAOBgNVHQ8BAf8EBAMCAQYwJQYDVR0RBB4wHKQaMBgxFjAUBgNVBAMTDUMxQzItMS0yMDQ4
LTcwHQYDVR0OBBYEFE98LXEkuKpRH3UwSWNDRuBY4BteMB8GA1UdIwQYMBaAFN6KF0+QWXyxC/d1
Mz0UtVEjd5VqMA0GCSqGSIb3DQEBBQUAA4IBAQAIcShSJ+veTuyOtfyMPtljBneKwLKmwB/WEWQp
0isQLYRXSO0AhMjZDei+yWAexfYOPIgpXbBgMlJ7leeoejsiP8xWtVRDybopVuSHvkMLjDeRaiO8
gYVzm/AF3gz23tNo48d1Zz/MD4674YeLUKdP1IUd4SXQ8fugiFB29ria9l9YTQrXBA2ocF5UT+QD
xvaYs9la27SgP74AigI05hAaEptIZXwHxS+gM+bEle5r3K4HWkSnzMtMCnhB094OOaYAhZa/FKvl
hSfhTVwxuZVE0c6VXbp6k9w5ZgWN8UXZGQE9W5qLiPtuo+aaUwURaOyID4ROdFA8NItmohpVReCw
MIIFhTCCBG2gAwIBAgIQXLd9GTWYtJqCVi/S1qbPCDANBgkqhkiG9w0BAQUFADCByjELMAkGA1UE
BhMCVVMxFzAVBgNVBAoTDlZlcmlTaWduLCBJbmMuMR8wHQYDVQQLExZWZXJpU2lnbiBUcnVzdCBO
ZXR3b3JrMTowOAYDVQQLEzEoYykgMTk5OSBWZXJpU2lnbiwgSW5jLiAtIEZvciBhdXRob3JpemVk
IHVzZSBvbmx5MUUwQwYDVQQDEzxWZXJpU2lnbiBDbGFzcyAxIFB1YmxpYyBQcmltYXJ5IENlcnRp
ZmljYXRpb24gQXV0aG9yaXR5IC0gRzMwHhcNMTEwMzMxMDAwMDAwWhcNMjEwMzMwMjM1OTU5WjB7
MQswCQYDVQQGEwJERTEpMCcGA1UEChMgRGV1dHNjaGVyIFNwYXJrYXNzZW4gVmVybGFnIEdtYkgx
HzAdBgNVBAsTFlZlcmlTaWduIFRydXN0IE5ldHdvcmsxIDAeBgNVBAMTF1MtVFJVU1QgQ2xhc3Mg
MSBDQSAtIEcxMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA1GHvEu9rrsxOgXFcY8WJ
39pi8hchkq3jCfU3Pr53d4oVS+CuoXCjpsAuaJ+++zM5NA778jGcPDUV3vdnL89EePhIWuM5SUXN
PhueJ6hJGssKrPFu/D9iuoTk3PiwCAZgI8zLXAPAOYHGQBtjRf+7a0MXUp2cNSQ3L8jmgN9FES3F
9P6TdKcCq9LEttjGFxqRlhIvUHxoQh+PWXSlNjXqY81xNrcdR3DbUmh5B+I7V3cT00xad5juDM5N
R7ItbyOyGJk53gjlqKD0Y7GuYVKYH34oc3SBk39p6MKYvIlZLzuYz0Z7w5OM9SVlUUPOC/XmuGGm
/bl1bChYn2COO0t6NwIDAQABo4IBszCCAa8wDwYDVR0TAQH/BAUwAwEB/zAYBgNVHSAEETAPMA0G
C2CGSAGG+EUBBxcBMDQGA1UdHwQtMCswKaAnoCWGI2h0dHA6Ly9jcmwudmVyaXNpZ24uY29tL3Bj
YTEtZzMuY3JsMA4GA1UdDwEB/wQEAwIBBjApBgNVHREEIjAgpB4wHDEaMBgGA1UEAxMRQWZmU0ND
Mi0yMDQ4LTEtNTQwHQYDVR0OBBYEFN6KF0+QWXyxC/d1Mz0UtVEjd5VqMIHxBgNVHSMEgekwgeah
gdCkgc0wgcoxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5WZXJpU2lnbiwgSW5jLjEfMB0GA1UECxMW
VmVyaVNpZ24gVHJ1c3QgTmV0d29yazE6MDgGA1UECxMxKGMpIDE5OTkgVmVyaVNpZ24sIEluYy4g
LSBGb3IgYXV0aG9yaXplZCB1c2Ugb25seTFFMEMGA1UEAxM8VmVyaVNpZ24gQ2xhc3MgMSBQdWJs
aWMgUHJpbWFyeSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSAtIEczghEAi1t1VoRUhQsAz684SM6x
pDANBgkqhkiG9w0BAQUFAAOCAQEAJ4WFTFJhhbH2JMnU5ogwXK6DoUoyPXviMaLb+UJ5zCkUAqGC
jolEcRjjaghtbEnJllxIYS5AzoVHo+vQ5l48pxY5f9eqRDdLAvqof3yjg0PSN40PSy8kiIhGb8s+
WIvbqKPTvr7ovHCzKCZCiONHsLByoMkWWr822QIlW+co9FT4NVZ4IdWnlmFIHn4UWDbQeWYUZyzl
OW2cA/Ds6ULQ98bSjh0RFh3VpjqNPJH8z1S+4SXJPrYLZoDBW7YLzqo7YjxXSRHVtX0MXaGq5NHW
qiIrnHLjbdEybmQrJeXX3qmFFE6ITrf/Y1ev69JzTspap/2FguH1NrDwatxpaKwwDzGCBOQwggTg
AgEBMIIBDjCB+TELMAkGA1UEBhMCREUxKTAnBgNVBAoTIERldXRzY2hlciBTcGFya2Fzc2VuIFZl
cmxhZyBHbWJIMR8wHQYDVQQLExZWZXJpU2lnbiBUcnVzdCBOZXR3b3JrMTkwNwYDVQQLEzBUZXJt
cyBvZiB1c2UgYXQgaHR0cHM6Ly93d3cucy10cnVzdC5kZS9ycGEgKGMpMTExNTAzBgNVBAsTLENs
YXNzIDEgTWFuYWdlZCBQS0kgSW5kaXZpZHVhbCBTdWJzY3JpYmVyIENBMSwwKgYDVQQDEyNTLVRS
VVNUIENsYXNzIDEgQ0EgLSBTaWNoZXJlIEUtTWFpbAIQCu52DI3XDfNWisacuQZqjDAJBgUrDgMC
GgUAoIICqTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNDEwMDEx
MjQyNDlaMCMGCSqGSIb3DQEJBDEWBBTNcG8lokrSv9S7EpudO7Bno6yGRTCCASEGCSsGAQQBgjcQ
BDGCARIwggEOMIH5MQswCQYDVQQGEwJERTEpMCcGA1UEChMgRGV1dHNjaGVyIFNwYXJrYXNzZW4g
VmVybGFnIEdtYkgxHzAdBgNVBAsTFlZlcmlTaWduIFRydXN0IE5ldHdvcmsxOTA3BgNVBAsTMFRl
cm1zIG9mIHVzZSBhdCBodHRwczovL3d3dy5zLXRydXN0LmRlL3JwYSAoYykxMTE1MDMGA1UECxMs
Q2xhc3MgMSBNYW5hZ2VkIFBLSSBJbmRpdmlkdWFsIFN1YnNjcmliZXIgQ0ExLDAqBgNVBAMTI1Mt
VFJVU1QgQ2xhc3MgMSBDQSAtIFNpY2hlcmUgRS1NYWlsAhAK7nYMjdcN81aKxpy5BmqMMIIBIwYL
KoZIhvcNAQkQAgsxggESoIIBDjCB+TELMAkGA1UEBhMCREUxKTAnBgNVBAoTIERldXRzY2hlciBT
cGFya2Fzc2VuIFZlcmxhZyBHbWJIMR8wHQYDVQQLExZWZXJpU2lnbiBUcnVzdCBOZXR3b3JrMTkw
NwYDVQQLEzBUZXJtcyBvZiB1c2UgYXQgaHR0cHM6Ly93d3cucy10cnVzdC5kZS9ycGEgKGMpMTEx
NTAzBgNVBAsTLENsYXNzIDEgTWFuYWdlZCBQS0kgSW5kaXZpZHVhbCBTdWJzY3JpYmVyIENBMSww
KgYDVQQDEyNTLVRSVVNUIENsYXNzIDEgQ0EgLSBTaWNoZXJlIEUtTWFpbAIQCu52DI3XDfNWisac
uQZqjDANBgkqhkiG9w0BAQEFAASCAQAVCWkRSovJP387Q1/F4f4K9o0GvxuauoZNf0AyvqqLSkO4
oiIiEVROcoI+E18Xd2vToPN9ebvG185cP/nUAHeEdU1R2Vp6F6bHzJuXjnMG9NUiRDjEB37qDA6s
vQLoOsT+uhxNY2nLZQFaG2QUO6R+0uQFAVEdHy81MJsiilVjDmmb0JmXhETu2Z3Ba7Qnh2hCkcwZ
0UKBgDpg5yPL+++PhxSvPY/s++D4K5yQcPiBiGAFnLUH9J4jsR7NrFInppwQVOcW8pA3hXjLx2OW
TtveAke5DqT+bdr7xOi2YQQVvOk6RmEI+9AP2fE3WsYfm9jO/IUKJ8fTT5d1AkggXXs6AAAAAAAA

--Apple-Mail=_A90CDE06-7B29-4DD8-AD82-2EC6FF736A81--
