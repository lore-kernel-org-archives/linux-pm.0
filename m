From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Memory allocations in .suspend became very unreliable
Date: Fri, 15 Jan 2010 11:59:04 +0200
Message-ID: <1263549544.3112.10.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

I know that this is very controversial, because here I want to describe
a problem in a proprietary driver that happens now in 2.6.33-rc3
I am taking about nvidia driver.

Some time ago I did very long hibernate test and found no errors after
more that 200 cycles.

Now I update to 2.6.33 and notice that system will hand when nvidia
driver allocates memory is their .suspend functions. 
This could fail in 2.6.32 if I would run many memory hungry
applications, but now this happens with most of memory free.

I added some printks to function used to allocate memory in nvidia
driver and found out that contrary to my belief, they don't allocate
much memory there.

Here is the log:

<4>[  412.022746] Freezing user space processes ... (elapsed 0.01 seconds) done.
<4>[  412.042872] Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
<6>[  412.062979] PM: Preallocating image memory... done (allocated 326858 pages)
<6>[  412.302822] PM: Allocated 1307432 kbytes in 0.23 seconds (5684.48 MB/s)
<5>[  412.342974] sd 0:0:0:0: [sda] Synchronizing SCSI cache
<7>[  412.361201] ACPI handle has no context!
<6>[  412.361315] sdhci-pci 0000:07:00.1: PCI INT B disabled
<7>[  412.361434] ACPI handle has no context!
<4>[  412.441488] NVM: allocating 7576 bytes of memory
<4>[  412.441597] NVM: allocating 72 bytes of memory
<4>[  412.441732] NVM: allocating 208 bytes of memory
<4>[  412.441836] NVM: allocating 72 bytes of memory
<4>[  412.442531] NVM: allocating 200 bytes of memory
<4>[  412.442639] NVM: allocating 72 bytes of memory
<4>[  412.442786] NVM: allocating 328 bytes of memory
<4>[  412.442888] NVM: allocating 72 bytes of memory
<4>[  412.442990] NVM: allocating 200 bytes of memory
<4>[  412.443111] NVM: allocating 376 bytes of memory
<4>[  412.443229] NVM: allocating 328 bytes of memory
<4>[  412.443330] NVM: allocating 72 bytes of memory
<4>[  412.443430] NVM: allocating 144 bytes of memory
<4>[  412.443546] NVM: allocating 376 bytes of memory
<4>[  412.443689] NVM: allocating 136 bytes of memory
<4>[  412.443791] NVM: allocating 136 bytes of memory
<4>[  412.443893] NVM: allocating 136 bytes of memory
<4>[  412.444002] NVM: allocating 96 bytes of memory
<4>[  412.444104] NVM: allocating 176 bytes of memory
<4>[  412.444210] NVM: allocating 200 bytes of memory
<4>[  412.444317] NVM: allocating 96 bytes of memory
<4>[  412.444418] NVM: allocating 176 bytes of memory
<4>[  412.444520] NVM: allocating 200 bytes of memory
<4>[  412.444624] NVM: allocating 96 bytes of memory
<4>[  412.444725] NVM: allocating 176 bytes of memory
<4>[  412.444828] NVM: allocating 200 bytes of memory
<4>[  412.444932] NVM: allocating 2048 bytes of memory
<4>[  412.445037] NVM: allocating 384 bytes of memory
<4>[  412.445140] NVM: allocating 136 bytes of memory
<4>[  412.445240] NVM: allocating 136 bytes of memory
<4>[  412.445425] NVM: allocating 328 bytes of memory
<4>[  412.445529] NVM: allocating 136 bytes of memory
<4>[  412.445653] NVM: allocating 136 bytes of memory
<4>[  412.445757] NVM: allocating 148 bytes of memory
<4>[  412.445922] NVM: allocating 1296 bytes of memory
<4>[  412.446039] NVM: allocating 37888 bytes of memory
<4>[  412.446156] NVM: allocating 72 bytes of memory
<4>[  412.446280] NVM: allocating 328 bytes of memory
<4>[  412.446383] NVM: allocating 72 bytes of memory
<4>[  412.446483] NVM: allocating 144 bytes of memory
<4>[  412.446600] NVM: allocating 376 bytes of memory
<4>[  412.446749] NVM: allocating 136 bytes of memory
<4>[  412.446853] NVM: allocating 148 bytes of memory
<4>[  412.447026] NVM: allocating 136 bytes of memory
<4>[  412.447130] NVM: allocating 148 bytes of memory
<4>[  412.447304] NVM: allocating 872 bytes of memory
<4>[  412.447408] NVM: allocating 96 bytes of memory
<4>[  412.447510] NVM: allocating 176 bytes of memory
<4>[  412.447614] NVM: allocating 200 bytes of memory
<4>[  412.447721] NVM: allocating 148 bytes of memory
<4>[  412.447826] NVM: allocating 148 bytes of memory
<4>[  412.447974] NVM: allocating 328 bytes of memory
<4>[  412.448078] NVM: allocating 136 bytes of memory
<4>[  412.448503] NVM: allocating 72 bytes of memory
<4>[  412.448625] NVM: allocating 328 bytes of memory
<4>[  412.448728] NVM: allocating 136 bytes of memory
<4>[  412.448863] NVM: allocating 72 bytes of memory
<4>[  412.448996] NVM: allocating 200 bytes of memory
<4>[  412.449097] NVM: allocating 136 bytes of memory
<4>[  412.449198] NVM: allocating 72 bytes of memory
<4>[  412.449485] NVM: allocating 1296 bytes of memory
<4>[  412.449587] NVM: allocating 1296 bytes of memory
<4>[  412.449727] NVM: allocating 1552 bytes of memory
<4>[  412.449829] NVM: allocating 1416 bytes of memory
<4>[  412.450607] NVM: allocating 200 bytes of memory
<4>[  412.450717] NVM: allocating 72 bytes of memory
<4>[  412.450855] NVM: allocating 328 bytes of memory
<4>[  412.450957] NVM: allocating 72 bytes of memory
<4>[  412.451058] NVM: allocating 1544 bytes of memory
<4>[  412.451176] NVM: allocating 376 bytes of memory
<4>[  412.451309] NVM: allocating 136 bytes of memory
<4>[  412.451416] NVM: allocating 148 bytes of memory
<4>[  412.451637] NVM: allocating 200 bytes of memory
<4>[  412.451741] NVM: allocating 136 bytes of memory
<4>[  412.451844] NVM: allocating 72 bytes of memory
<4>[  412.451974] NVM: allocating 328 bytes of memory
<4>[  412.452075] NVM: allocating 72 bytes of memory
<4>[  412.452176] NVM: allocating 136 bytes of memory
<4>[  412.452292] NVM: allocating 376 bytes of memory
<4>[  412.452411] NVM: allocating 136 bytes of memory
<4>[  412.452606] NVM: allocating 64 bytes of memory
<4>[  412.452708] NVM: allocating 136 bytes of memory
<4>[  412.452812] NVM: allocating 148 bytes of memory
<4>[  412.452974] NVM: allocating 56 bytes of memory
<4>[  412.453075] NVM: allocating 56 bytes of memory
<4>[  412.454466] NVM: allocating 120 bytes of memory
<4>[  412.454568] NVM: allocating 15 bytes of memory
<4>[  412.454688] NVM: allocating 2192 bytes of memory
<4>[  412.454791] NVM: allocating 2056 bytes of memory
<4>[  412.455715] NVM: allocating 200 bytes of memory
<4>[  412.455823] NVM: allocating 72 bytes of memory
<4>[  412.455963] NVM: allocating 328 bytes of memory
<4>[  412.456065] NVM: allocating 72 bytes of memory
<4>[  412.456167] NVM: allocating 2184 bytes of memory
<4>[  412.456287] NVM: allocating 376 bytes of memory
<4>[  412.456420] NVM: allocating 136 bytes of memory
<4>[  412.456527] NVM: allocating 148 bytes of memory
<4>[  412.456761] NVM: allocating 200 bytes of memory
<4>[  412.456864] NVM: allocating 136 bytes of memory
<4>[  412.456964] NVM: allocating 72 bytes of memory
<4>[  412.457095] NVM: allocating 328 bytes of memory
<4>[  412.457197] NVM: allocating 72 bytes of memory
<4>[  412.457298] NVM: allocating 136 bytes of memory
<4>[  412.457415] NVM: allocating 376 bytes of memory
<4>[  412.457534] NVM: allocating 136 bytes of memory
<4>[  412.457686] NVM: allocating 64 bytes of memory
<4>[  412.457787] NVM: allocating 136 bytes of memory
<4>[  412.457890] NVM: allocating 148 bytes of memory
<4>[  412.458057] NVM: allocating 56 bytes of memory
<4>[  412.458158] NVM: allocating 56 bytes of memory
<4>[  412.459509] NVM: allocating 2192 bytes of memory
<4>[  412.459614] NVM: allocating 2056 bytes of memory
<4>[  412.460464] NVM: allocating 200 bytes of memory
<4>[  412.460574] NVM: allocating 72 bytes of memory
<4>[  412.460713] NVM: allocating 328 bytes of memory
<4>[  412.460818] NVM: allocating 72 bytes of memory
<4>[  412.460919] NVM: allocating 2184 bytes of memory
<4>[  412.461040] NVM: allocating 376 bytes of memory
<4>[  412.461172] NVM: allocating 136 bytes of memory
<4>[  412.461278] NVM: allocating 148 bytes of memory
<4>[  412.461511] NVM: allocating 200 bytes of memory
<4>[  412.461615] NVM: allocating 136 bytes of memory
<4>[  412.461717] NVM: allocating 72 bytes of memory
<4>[  412.461848] NVM: allocating 328 bytes of memory
<4>[  412.461950] NVM: allocating 72 bytes of memory
<4>[  412.462051] NVM: allocating 136 bytes of memory
<4>[  412.462167] NVM: allocating 376 bytes of memory
<4>[  412.462286] NVM: allocating 136 bytes of memory
<4>[  412.462437] NVM: allocating 64 bytes of memory
<4>[  412.462580] NVM: allocating 136 bytes of memory
<4>[  412.462683] NVM: allocating 148 bytes of memory
<4>[  412.462852] NVM: allocating 56 bytes of memory
<4>[  412.462952] NVM: allocating 56 bytes of memory
<4>[  412.464271] NVM: allocating 272 bytes of memory
<4>[  412.464374] NVM: allocating 136 bytes of memory
<4>[  412.465035] NVM: allocating 200 bytes of memory
<4>[  412.465145] NVM: allocating 72 bytes of memory
<4>[  412.465285] NVM: allocating 328 bytes of memory
<4>[  412.465389] NVM: allocating 72 bytes of memory
<4>[  412.465490] NVM: allocating 264 bytes of memory
<4>[  412.465610] NVM: allocating 376 bytes of memory
<4>[  412.465741] NVM: allocating 136 bytes of memory
<4>[  412.465847] NVM: allocating 148 bytes of memory
<4>[  412.466053] NVM: allocating 200 bytes of memory
<4>[  412.466156] NVM: allocating 136 bytes of memory
<4>[  412.466258] NVM: allocating 72 bytes of memory
<4>[  412.466390] NVM: allocating 328 bytes of memory
<4>[  412.466493] NVM: allocating 72 bytes of memory
<4>[  412.466594] NVM: allocating 136 bytes of memory
<4>[  412.466711] NVM: allocating 376 bytes of memory
<4>[  412.466831] NVM: allocating 136 bytes of memory
<4>[  412.466982] NVM: allocating 64 bytes of memory
<4>[  412.467083] NVM: allocating 136 bytes of memory
<4>[  412.467186] NVM: allocating 148 bytes of memory
<4>[  412.467327] NVM: allocating 56 bytes of memory
<4>[  412.467429] NVM: allocating 56 bytes of memory
<4>[  412.468793] NVM: allocating 880 bytes of memory
<4>[  412.468896] NVM: allocating 744 bytes of memory
<4>[  412.470051] NVM: allocating 200 bytes of memory
<4>[  412.470173] NVM: allocating 72 bytes of memory
<4>[  412.470312] NVM: allocating 328 bytes of memory
<4>[  412.470415] NVM: allocating 72 bytes of memory
<4>[  412.470517] NVM: allocating 872 bytes of memory
<4>[  412.470636] NVM: allocating 376 bytes of memory
<4>[  412.470767] NVM: allocating 136 bytes of memory
<4>[  412.471862] NVM: allocating 148 bytes of memory
<4>[  412.472078] NVM: allocating 200 bytes of memory
<4>[  412.472180] NVM: allocating 136 bytes of memory
<4>[  412.472282] NVM: allocating 72 bytes of memory
<4>[  412.472413] NVM: allocating 328 bytes of memory
<4>[  412.472549] NVM: allocating 72 bytes of memory
<4>[  412.472651] NVM: allocating 136 bytes of memory
<4>[  412.472767] NVM: allocating 376 bytes of memory
<4>[  412.472887] NVM: allocating 136 bytes of memory
<4>[  412.473038] NVM: allocating 64 bytes of memory
<4>[  412.473138] NVM: allocating 136 bytes of memory
<4>[  412.473241] NVM: allocating 148 bytes of memory
<4>[  412.473393] NVM: allocating 56 bytes of memory
<4>[  412.473495] NVM: allocating 56 bytes of memory
<4>[  412.474798] NVM: allocating 256 bytes of memory
<4>[  412.475005] NVM: allocating 152 bytes of memory
<4>[  412.475108] NVM: allocating 16 bytes of memory
<4>[  412.475744] NVM: allocating 200 bytes of memory
<4>[  412.475853] NVM: allocating 72 bytes of memory
<4>[  412.475993] NVM: allocating 328 bytes of memory
<4>[  412.476096] NVM: allocating 72 bytes of memory
<4>[  412.476198] NVM: allocating 144 bytes of memory
<4>[  412.476318] NVM: allocating 376 bytes of memory
<4>[  412.476451] NVM: allocating 136 bytes of memory
<4>[  412.476556] NVM: allocating 148 bytes of memory
<4>[  412.476761] NVM: allocating 200 bytes of memory
<4>[  412.476862] NVM: allocating 136 bytes of memory
<4>[  412.476964] NVM: allocating 72 bytes of memory
<4>[  412.477095] NVM: allocating 328 bytes of memory
<4>[  412.477198] NVM: allocating 72 bytes of memory
<4>[  412.477300] NVM: allocating 136 bytes of memory
<4>[  412.477417] NVM: allocating 376 bytes of memory
<4>[  412.477536] NVM: allocating 136 bytes of memory
<4>[  412.477686] NVM: allocating 64 bytes of memory
<4>[  412.477787] NVM: allocating 136 bytes of memory
<4>[  412.477890] NVM: allocating 148 bytes of memory
<4>[  412.478031] NVM: allocating 56 bytes of memory
<4>[  412.478133] NVM: allocating 56 bytes of memory
<4>[  412.479449] NVM: allocating 192 bytes of memory
<4>[  412.479550] NVM: allocating 56 bytes of memory
<4>[  412.480202] NVM: allocating 200 bytes of memory
<4>[  412.480310] NVM: allocating 72 bytes of memory
<4>[  412.480448] NVM: allocating 328 bytes of memory
<4>[  412.480551] NVM: allocating 72 bytes of memory
<4>[  412.480653] NVM: allocating 184 bytes of memory
<4>[  412.480770] NVM: allocating 376 bytes of memory
<4>[  412.480903] NVM: allocating 136 bytes of memory
<4>[  412.481008] NVM: allocating 148 bytes of memory
<4>[  412.481211] NVM: allocating 200 bytes of memory
<4>[  412.481313] NVM: allocating 136 bytes of memory
<4>[  412.481416] NVM: allocating 72 bytes of memory
<4>[  412.481548] NVM: allocating 328 bytes of memory
<4>[  412.481651] NVM: allocating 72 bytes of memory
<4>[  412.481752] NVM: allocating 136 bytes of memory
<4>[  412.481868] NVM: allocating 376 bytes of memory
<4>[  412.481986] NVM: allocating 136 bytes of memory
<4>[  412.482135] NVM: allocating 64 bytes of memory
<4>[  412.482237] NVM: allocating 136 bytes of memory
<4>[  412.482339] NVM: allocating 148 bytes of memory
<4>[  412.482481] NVM: allocating 56 bytes of memory
<4>[  412.482626] NVM: allocating 56 bytes of memory
<4>[  412.483945] NVM: allocating 880 bytes of memory
<4>[  412.484047] NVM: allocating 744 bytes of memory
<4>[  412.485181] NVM: allocating 200 bytes of memory
<4>[  412.485291] NVM: allocating 72 bytes of memory
<4>[  412.485431] NVM: allocating 328 bytes of memory
<4>[  412.485535] NVM: allocating 72 bytes of memory
<4>[  412.485637] NVM: allocating 872 bytes of memory
<4>[  412.485756] NVM: allocating 376 bytes of memory
<4>[  412.485888] NVM: allocating 136 bytes of memory
<4>[  412.485995] NVM: allocating 148 bytes of memory
<4>[  412.486213] NVM: allocating 200 bytes of memory
<4>[  412.486315] NVM: allocating 136 bytes of memory
<4>[  412.486417] NVM: allocating 72 bytes of memory
<4>[  412.486548] NVM: allocating 328 bytes of memory
<4>[  412.486650] NVM: allocating 72 bytes of memory
<4>[  412.486751] NVM: allocating 136 bytes of memory
<4>[  412.486868] NVM: allocating 376 bytes of memory
<4>[  412.486988] NVM: allocating 136 bytes of memory
<4>[  412.487138] NVM: allocating 64 bytes of memory
<4>[  412.487240] NVM: allocating 136 bytes of memory
<4>[  412.487342] NVM: allocating 148 bytes of memory
<4>[  412.487493] NVM: allocating 56 bytes of memory
<4>[  412.487594] NVM: allocating 56 bytes of memory
<4>[  412.488897] NVM: allocating 256 bytes of memory
<4>[  412.489103] NVM: allocating 152 bytes of memory
<4>[  412.489206] NVM: allocating 16 bytes of memory
<4>[  412.489851] NVM: allocating 200 bytes of memory
<4>[  412.489960] NVM: allocating 72 bytes of memory
<4>[  412.490125] NVM: allocating 328 bytes of memory
<4>[  412.490229] NVM: allocating 72 bytes of memory
<4>[  412.490329] NVM: allocating 144 bytes of memory
<4>[  412.490448] NVM: allocating 376 bytes of memory
<4>[  412.490580] NVM: allocating 136 bytes of memory
<4>[  412.490686] NVM: allocating 148 bytes of memory
<4>[  412.490888] NVM: allocating 200 bytes of memory
<4>[  412.490991] NVM: allocating 136 bytes of memory
<4>[  412.491092] NVM: allocating 72 bytes of memory
<4>[  412.491224] NVM: allocating 328 bytes of memory
<4>[  412.491325] NVM: allocating 72 bytes of memory
<4>[  412.491426] NVM: allocating 136 bytes of memory
<4>[  412.491543] NVM: allocating 376 bytes of memory
<4>[  412.491664] NVM: allocating 136 bytes of memory
<4>[  412.491814] NVM: allocating 64 bytes of memory
<4>[  412.491916] NVM: allocating 136 bytes of memory
<4>[  412.492020] NVM: allocating 148 bytes of memory
<4>[  412.492160] NVM: allocating 56 bytes of memory
<4>[  412.492262] NVM: allocating 56 bytes of memory
<4>[  412.493588] NVM: allocating 192 bytes of memory
<4>[  412.493692] NVM: allocating 56 bytes of memory
<4>[  412.513530] NVM: allocating 200 bytes of memory
<4>[  412.513642] NVM: allocating 72 bytes of memory
<4>[  412.513782] NVM: allocating 328 bytes of memory
<4>[  412.513887] NVM: allocating 72 bytes of memory
<4>[  412.513990] NVM: allocating 184 bytes of memory
<4>[  412.514111] NVM: allocating 376 bytes of memory
<4>[  412.514246] NVM: allocating 136 bytes of memory
<4>[  412.514353] NVM: allocating 148 bytes of memory
<4>[  412.514559] NVM: allocating 200 bytes of memory
<4>[  412.514663] NVM: allocating 136 bytes of memory
<4>[  412.514767] NVM: allocating 72 bytes of memory
<4>[  412.514900] NVM: allocating 328 bytes of memory
<4>[  412.515003] NVM: allocating 72 bytes of memory
<4>[  412.515107] NVM: allocating 136 bytes of memory
<4>[  412.515225] NVM: allocating 376 bytes of memory
<4>[  412.515346] NVM: allocating 136 bytes of memory
<4>[  412.515498] NVM: allocating 64 bytes of memory
<4>[  412.515601] NVM: allocating 136 bytes of memory
<4>[  412.515704] NVM: allocating 148 bytes of memory
<4>[  412.515847] NVM: allocating 56 bytes of memory
<4>[  412.515949] NVM: allocating 56 bytes of memory
<4>[  412.517272] NVM: allocating 880 bytes of memory
<4>[  412.517378] NVM: allocating 744 bytes of memory
<4>[  412.533382] NVM: allocating 200 bytes of memory
<4>[  412.533493] NVM: allocating 72 bytes of memory
<4>[  412.533634] NVM: allocating 328 bytes of memory
<4>[  412.533737] NVM: allocating 72 bytes of memory
<4>[  412.533839] NVM: allocating 872 bytes of memory
<4>[  412.533956] NVM: allocating 376 bytes of memory
<4>[  412.534088] NVM: allocating 136 bytes of memory
<4>[  412.534196] NVM: allocating 148 bytes of memory
<4>[  412.534414] NVM: allocating 200 bytes of memory
<4>[  412.534516] NVM: allocating 136 bytes of memory
<4>[  412.534619] NVM: allocating 72 bytes of memory
<4>[  412.534750] NVM: allocating 328 bytes of memory
<4>[  412.534851] NVM: allocating 72 bytes of memory
<4>[  412.534951] NVM: allocating 136 bytes of memory
<4>[  412.535067] NVM: allocating 376 bytes of memory
<4>[  412.535187] NVM: allocating 136 bytes of memory
<4>[  412.535338] NVM: allocating 64 bytes of memory
<4>[  412.535439] NVM: allocating 136 bytes of memory
<4>[  412.535543] NVM: allocating 148 bytes of memory
<4>[  412.535693] NVM: allocating 56 bytes of memory
<4>[  412.535794] NVM: allocating 56 bytes of memory
<4>[  412.537098] NVM: allocating 256 bytes of memory
<4>[  412.537305] NVM: allocating 152 bytes of memory
<4>[  412.537406] NVM: allocating 16 bytes of memory
<4>[  412.538050] NVM: allocating 200 bytes of memory
<4>[  412.538160] NVM: allocating 72 bytes of memory
<4>[  412.538300] NVM: allocating 328 bytes of memory
<4>[  412.538403] NVM: allocating 72 bytes of memory
<4>[  412.538506] NVM: allocating 144 bytes of memory
<4>[  412.538625] NVM: allocating 376 bytes of memory
<4>[  412.538758] NVM: allocating 136 bytes of memory
<4>[  412.538865] NVM: allocating 148 bytes of memory
<4>[  412.539069] NVM: allocating 200 bytes of memory
<4>[  412.539171] NVM: allocating 136 bytes of memory
<4>[  412.539274] NVM: allocating 72 bytes of memory
<4>[  412.539403] NVM: allocating 328 bytes of memory
<4>[  412.539506] NVM: allocating 72 bytes of memory
<4>[  412.539608] NVM: allocating 136 bytes of memory
<4>[  412.539724] NVM: allocating 376 bytes of memory
<4>[  412.539842] NVM: allocating 136 bytes of memory
<4>[  412.539994] NVM: allocating 64 bytes of memory
<4>[  412.540129] NVM: allocating 136 bytes of memory
<4>[  412.540232] NVM: allocating 148 bytes of memory
<4>[  412.540372] NVM: allocating 56 bytes of memory
<4>[  412.540473] NVM: allocating 56 bytes of memory
<4>[  412.541792] NVM: allocating 192 bytes of memory
<4>[  412.541895] NVM: allocating 56 bytes of memory
<4>[  412.543645] NVM: allocating 200 bytes of memory
<4>[  412.543756] NVM: allocating 72 bytes of memory
<4>[  412.543897] NVM: allocating 328 bytes of memory
<4>[  412.544001] NVM: allocating 72 bytes of memory
<4>[  412.544103] NVM: allocating 184 bytes of memory
<4>[  412.544223] NVM: allocating 376 bytes of memory
<4>[  412.544355] NVM: allocating 136 bytes of memory
<4>[  412.544460] NVM: allocating 148 bytes of memory
<4>[  412.544663] NVM: allocating 200 bytes of memory
<4>[  412.544764] NVM: allocating 136 bytes of memory
<4>[  412.544866] NVM: allocating 72 bytes of memory
<4>[  412.544997] NVM: allocating 328 bytes of memory
<4>[  412.545099] NVM: allocating 72 bytes of memory
<4>[  412.545200] NVM: allocating 136 bytes of memory
<4>[  412.545315] NVM: allocating 376 bytes of memory
<4>[  412.545434] NVM: allocating 136 bytes of memory
<4>[  412.545585] NVM: allocating 64 bytes of memory
<4>[  412.545687] NVM: allocating 136 bytes of memory
<4>[  412.545790] NVM: allocating 148 bytes of memory
<4>[  412.545929] NVM: allocating 56 bytes of memory
<4>[  412.546030] NVM: allocating 56 bytes of memory
<4>[  412.547329] NVM: allocating 65536 bytes of memory
<6>[  463.045135] SysRq : Emergency Sync
<4>[  463.045433] Emergency Sync complete
<6>[  464.056489] SysRq : Emergency Remount R/O
<6>[  467.569124] SysRq : Resetting



I have even tried to increase SPARE_PAGES to 32 MB, but no luck.


Best regards,
Maxim Levitsky
