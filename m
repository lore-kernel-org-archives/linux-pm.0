From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 23 Jun 2006 01:51:00 +0200
Message-ID: <20060622235100.GA4940@elf.ucw.cz>
References: <1150946286.947.50.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606212105220.5498@g5.osdl.org>
	<1150952298.3633.20.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606220909220.5498@g5.osdl.org>
	<1151014893.4046.24.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606221527590.6483@g5.osdl.org>
	<1151017911.4046.55.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606221614280.6483@g5.osdl.org>
	<20060622233137.GE4462@elf.ucw.cz>
	<Pine.LNX.4.64.0606221641180.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606221641180.6483@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!


> > Well, apparently you were the first one to try to use netconsole for
> > s2ram debugging. Sorry -- we were using regular vgacon.
> =

> Sorry, but wrong answer.
> =

> The Mac Mini was the first machine when I decided to try using netconsole=
. =

> And I did so because it didn't work for me even before. It just so =

> happened that netconsole actually made things EVEN WORSE.
> =

> The other machines I've tried (without netconsole) haven't resumed either.

Well... here's list of machines we got to work (from suspend.sf.net
project):

it is not that short.
									Pavel

/* whitelist.c
 * whitelist of machines that are known to work somehow
 * and all the workarounds
 */

struct machine_entry
{
	const char *sys_vendor;
	const char *sys_product;
	const char *sys_version;
	const char *bios_version;
	unsigned int flags;
};

struct machine_entry whitelist[] =3D {
	{ "IBM",			"",		"ThinkPad X32",	"", RADEON_OFF|S3_BIOS|S3_MODE },
	{ "Hewlett Packard",	"",	"HP OmniBook XE3 GF           ","", VBE_POST|VBE_=
SAVE },
	{ "Acer            ",		"Extensa 4150 *",	"",	"", S3_BIOS|S3_MODE },
	{ "Acer           ",		"TravelMate C300",	"",	"", VBE_SAVE },
	/* Norbert Preining */
	{ "Acer",			"TravelMate 650",	"",	"", VBE_POST|VBE_SAVE },
	{ "Acer, inc.",			"TravelMate 3000 ",	"",	"", VBE_POST|VBE_SAVE },
	{ "Acer, inc.",			"Aspire 1690     ",	"",	"", VBE_POST|VBE_SAVE|NOFB },
	{ "Acer, inc.",			"Ferrari 4000    ",	"",	"", VBE_POST|VBE_SAVE|NOFB },
	{ "ASUSTEK ",			"L2000D",		"",	"", S3_MODE },
	{ "ASUSTEK ",			"L3000D",		"",	"", VBE_POST|VBE_SAVE },
	{ "ASUSTeK Computer Inc.        ",	"M6Ne      ",	"",	"", S3_MODE },
	/* M6VA, seraphim@glockenbach.net */
	{ "ASUSTeK Computer Inc.        ",	"M6VA      ",	"",	"", S3_BIOS|S3_MODE },
	/* ASUS V6V, Johannes Engel <j-engel@gmx.de> */
	{ "ASUSTeK Computer INC.",	"V6V",			"",	"", S3_MODE },
	/* ASUS M2400N, Daniel Gollub */
	{ "ERGOUK                       ",	"M2N       ",	"",	"", S3_BIOS|S3_MODE },
	{ "Compaq",			"Armada    E500  *",	"",	"", 0 },
	{ "Compaq",			"N620c=C2=A0*",		"",	"", S3_BIOS|S3_MODE },
	{ "Dell Computer Corporation",  "Inspiron 5150*",	"",	"", VBE_POST|VBE_SAV=
E },
	{ "Dell Computer Corporation",  "Inspiron 8000 *",	"",	"", VBE_POST|VBE_SA=
VE },
	{ "Dell Computer Corporation",  "Latitude C600 *",	"",	"", RADEON_OFF },
	{ "Dell Inc.",			"Latitude D410 *",	"",	"", VBE_POST|VBE_SAVE },
	{ "Dell Computer Corporation",  "Latitude D600 *",	"",	"", VBE_POST|VBE_SA=
VE|NOFB },
	{ "Dell Inc.",			"Latitude D610 *",	"",	"", VBE_POST|VBE_SAVE|NOFB },
	{ "Dell Computer Corporation",	"Latitude D800 *",	"",	"", VBE_POST|VBE_SAV=
E },
	/* Dell e1505, Alexander Antoniades */
	{ "Dell Inc.",			"MM061 *",		"",	"", 0 },
	{ "FUJITSU SIEMENS",		"Amilo A7640 ",		"",	"", VBE_POST|VBE_SAVE|S3_BIOS },
	{ "FUJITSU SIEMENS",		"Stylistic ST5000",	"",	"", S3_BIOS|S3_MODE },
	/* This is a desktop with onboard i810 video */
	{ "FUJITSU SIEMENS",		"SCENIC W300/W600",	"",	"", VBE_POST|VBE_SAVE },
	{ "Hewlett-Packard ",		"Compaq nx5000 *",	"",	"68BCU*", VBE_POST|VBE_SAVE =
},
	{ "Hewlett-Packard*",		"hp compaq nx5000 *",	"",	"68BCU*", VBE_POST|VBE_SA=
VE },
	{ "Hewlett-Packard",		"HP Compaq nc6000 *",	"",	"68BDD*", S3_BIOS|S3_MODE =
},
	{ "Hewlett-Packard",		"HP Compaq nx6125 *",	"",	"", VBE_SAVE|NOFB },
	{ "Hewlett-Packard",		"HP Compaq nc6230 *",	"",	"", VBE_SAVE|NOFB },
	{ "Hewlett-Packard",		"HP Compaq nx8220 *",	"",	"", VBE_SAVE|NOFB },
	{ "Hewlett-Packard",		"Presario R4100 *",	"",	"", S3_BIOS|S3_MODE },
	/* R51 and T43 confirmed by Christian Zoz */
	{ "IBM",			"1829*",	"ThinkPad R51",	"", 0 },
	/* R52, reported by Joscha Arenz */
	{ "IBM",			"1860*",		"",	"", S3_BIOS|S3_MODE },
	/* T30 */
	{ "IBM",			"2366*",		"",	"", RADEON_OFF },
	/* X31, confirmed by Bjoern Jacke */
	{ "IBM",			"2672*",		"",	"", S3_BIOS|S3_MODE|RADEON_OFF },
	/* X40 confirmed by Christian Deckelmann */
	{ "IBM",			"2371*",	"ThinkPad X40",	"", S3_BIOS|S3_MODE },
	/* T42p confirmed by Joe Shaw, T41p by Christoph Thiel (both 2373) */
	{ "IBM",			"2373*",		"",	"", S3_BIOS|S3_MODE },
	/* T41p, Stefan Gerber */
	{ "IBM",			"2374*",		"",	"", S3_BIOS|S3_MODE },
	{ "IBM",			"2668*",	"ThinkPad T43",	"", S3_BIOS|S3_MODE },
	/* G40 confirmed by David H"ademan */
	{ "IBM",			"2388*",		"",	"", VBE_SAVE },
	/* R32 */
	{ "IBM",			"2658*",		"",	"", 0 },
	/* R40 */
	{ "IBM",			"2681*",		"",	"", 0 },
	{ "IBM",			"2722*",		"",	"", 0 },
	/* Z60m, reported by Arkadiusz Miskiewicz */
	{ "IBM",			"2529*",		"",	"", S3_BIOS|S3_MODE },
	/* A21m, Raymund Will */
	{ "IBM",			"2628*",		"",	"", 0 },
	/* X60 / X60s */
	{ "LENOVO",			"1702*",		"",	"", S3_BIOS|S3_MODE },
	{ "LENOVO",			"1704*",		"",	"", S3_BIOS|S3_MODE },
	{ "LENOVO",			"1706*",		"",	"", S3_BIOS|S3_MODE },
	/* T60p */
	{ "LENOVO",			"2007*",		"",	"", S3_BIOS|S3_MODE },

	{ "LG Electronics",		"M1-3DGBG",		"",	"", S3_BIOS|S3_MODE },
	{ "Matsushita Electric Industrial Co.,Ltd.", "CF-51E*",	"",	"", VBE_POST|V=
BE_SAVE },
	{ "TOSHIBA",			"Libretto L5/TNK",	"",	"", 0 },
	{ "TOSHIBA",			"Libretto L5/TNKW",	"",	"", 0 },
	/* this is a Toshiba Satellite 4080XCDT, believe it or not :-( */
	{ "TOSHIBA",		"Portable PC",	"Version 1.0",	"Version 7.80", S3_MODE },
	{ "TOSHIBA",			"Satellite A30",	"",	"", VBE_SAVE },
	{ "TOSHIBA",			"Satellite L10",	"",	"", VBE_POST|VBE_SAVE },
	{ "TOSHIBA",			"TECRA S3",		"",	"", 0 },
	{ "Samsung",			"SQ10",			"",	"", VBE_POST|VBE_SAVE },
	{ "Samsung Electronics",	"SX20S",		"",	"", S3_BIOS|S3_MODE },
	{ "SHARP                           ",	"PC-AR10 *",	"",	"", 0 },
	{ "Sony Corporation",		"VGN-FS115B",		"",	"", S3_BIOS|S3_MODE },
	{ "Sony Corporation",		"PCG-GRT995MP*",	"",	"", 0 },
	/* VIA EPIA M Mini-ITX Motherboard with onboard gfx, reported by Monica Sc=
hilling */
	{ "VIA Technologies, Inc.",	"VT8623-8235",		"",	"", S3_MODE },

	// entries below are imported from acpi-support 0.59 and though "half know=
n".
	{ "ASUSTeK Computer Inc.",	"L7000G series Notebook PC*", "","", VBE_POST|V=
BE_SAVE|UNSURE },
	{ "ASUSTeK Computer Inc.",	"W5A*",			"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "Acer",			"TravelMate 290*",	"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "Acer",			"TravelMate 660*",	"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "Acer",			"Aspire 2000*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "Acer, inc.",			"TravelMate 8100*",	"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "Acer, inc.",			"Aspire 3000*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "Dell Inc.",			"Inspiron 700m*",	"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "Dell Inc.",			"Inspiron 1200*",	"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "Dell Inc.",			"Inspiron 6000*",	"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "Dell Inc.",			"Inspiron 8100*",	"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "Dell Inc.",			"Inspiron 8200*",	"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "Dell Inc.",			"Inspiron 8600*",	"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "Dell Inc.",			"Inspiron 9300*",	"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "Dell Inc.",			"Latitude 110L*",	"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "Dell Inc.",			"Latitude D510*",	"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "Dell Inc.",			"Latitude D810*",	"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "Dell Inc.",			"Latitude X1*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "Dell Inc.",			"Latitude X300*",	"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "Dell Inc.",			"Precision M20*",	"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "Dell Computer Corporation",	"Inspiron 700m*",	"",	"", VBE_POST|VBE_SAVE=
|UNSURE },
	{ "Dell Computer Corporation",	"Inspiron 1200*",	"",	"", VBE_POST|VBE_SAVE=
|UNSURE },
	{ "Dell Computer Corporation",	"Inspiron 6000*",	"",	"", VBE_POST|VBE_SAVE=
|UNSURE },
	{ "Dell Computer Corporation",	"Inspiron 8100*",	"",	"", VBE_POST|VBE_SAVE=
|UNSURE },
	{ "Dell Computer Corporation",	"Inspiron 8200*",	"",	"", VBE_POST|VBE_SAVE=
|UNSURE },
	{ "Dell Computer Corporation",	"Inspiron 8600*",	"",	"", VBE_POST|VBE_SAVE=
|UNSURE },
	{ "Dell Computer Corporation",	"Inspiron 9300*",	"",	"", VBE_POST|VBE_SAVE=
|UNSURE },
	{ "Dell Computer Corporation",	"Latitude 110L*",	"",	"", VBE_POST|VBE_SAVE=
|UNSURE },
	{ "Dell Computer Corporation",	"Latitude D410*",	"",	"", VBE_POST|VBE_SAVE=
|UNSURE },
	{ "Dell Computer Corporation",	"Latitude D510*",	"",	"", VBE_POST|VBE_SAVE=
|UNSURE },
	{ "Dell Computer Corporation",	"Latitude D810*",	"",	"", VBE_POST|VBE_SAVE=
|UNSURE },
	{ "Dell Computer Corporation",	"Latitude X1*",		"",	"", VBE_POST|VBE_SAVE|=
UNSURE },
	{ "Dell Computer Corporation",	"Latitude X300*",	"",	"", VBE_POST|VBE_SAVE=
|UNSURE },
	{ "Dell Computer Corporation",	"Precision M20*",	"",	"", VBE_POST|VBE_SAVE=
|UNSURE },
	{ "ECS",			"G556 Centrino*",	"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "FUJITSU",			"Amilo M*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "FUJITSU",			"LifeBook S Series*",	"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "FUJITSU",			"LIFEBOOK S6120*",	"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "FUJITSU",			"LIFEBOOK P7010*",	"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "FUJITSU SIEMENS",		"Amilo M*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "FUJITSU SIEMENS",		"LifeBook S Series*",	"",	"", VBE_POST|VBE_SAVE|UNSU=
RE },
	{ "FUJITSU SIEMENS",		"LIFEBOOK S6120*",	"",	"", VBE_POST|VBE_SAVE|UNSURE =
},
	{ "FUJITSU SIEMENS",		"LIFEBOOK P7010*",	"",	"", VBE_POST|VBE_SAVE|UNSURE =
},
	{ "Hewlett-Packard",		"HP Compaq nc4200*",	"",	"", VBE_POST|VBE_SAVE|UNSUR=
E },
	{ "Hewlett-Packard",		"HP Compaq nx6110*",	"",	"", VBE_POST|VBE_SAVE|UNSUR=
E },
	{ "Hewlett-Packard",		"HP Compaq nc6120*",	"",	"", VBE_POST|VBE_SAVE|UNSUR=
E },
	{ "Hewlett-Packard",		"HP Compaq nc6220*",	"",	"", VBE_POST|VBE_SAVE|UNSUR=
E },
	{ "Hewlett-Packard",		"HP Compaq nc8230*",	"",	"", VBE_POST|VBE_SAVE|UNSUR=
E },
	{ "Hewlett-Packard",		"HP Pavilion dv1000*",	"",	"", VBE_POST|VBE_SAVE|UNS=
URE },
	{ "Hewlett-Packard",		"HP Pavilion zt3000*",	"",	"", VBE_POST|VBE_SAVE|UNS=
URE },
	{ "Hewlett-Packard",		"HP Tablet PC Tx1100*",	"",	"", VBE_POST|VBE_SAVE|UN=
SURE },
	{ "Hewlett-Packard",		"HP Tablet PC TR1105*",	"",	"", VBE_POST|VBE_SAVE|UN=
SURE },
	{ "Hewlett-Packard",		"Pavilion zd7000*",	"",	"", VBE_POST|VBE_SAVE|UNSURE=
 },
	// R40
	{ "IBM",			"2682*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"2683*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"2692*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"2693*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"2696*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"2698*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"2699*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"2723*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"2724*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"2897*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	// R50/p
	{ "IBM",			"1829*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"1830*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"1831*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"1832*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"1833*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"1836*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"1840*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"1841*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	/* R50e needs not yet implemented save_video_pci_state :-(
	{ "IBM",			"1834*",		"",	"", UNSURE },
	{ "IBM",			"1842*",		"",	"", UNSURE },
	{ "IBM",			"2670*",		"",	"", UNSURE },
	*/
	// R52
	{ "IBM",			"1846*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"1847*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"1848*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"1849*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"1850*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"1870*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	// T21
	{ "IBM",			"2647*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"2648*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	// T23
	{ "IBM",			"475S*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	// T40/T41/T42/p
	{ "IBM",			"2375*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"2376*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"2378*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"2379*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	// T43
	{ "IBM",			"1871*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"1872*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"1873*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"1874*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"1875*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"1876*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	// T43/p
	{ "IBM",			"2668*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"2669*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"2678*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"2679*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"2686*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"2687*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	// X30
	{ "IBM",			"2673*",		"",	"", VBE_POST|VBE_SAVE|UNSURE|RADEON_OFF },
	{ "IBM",			"2884*",		"",	"", VBE_POST|VBE_SAVE|UNSURE|RADEON_OFF },
	{ "IBM",			"2885*",		"",	"", VBE_POST|VBE_SAVE|UNSURE|RADEON_OFF },
	{ "IBM",			"2890*",		"",	"", VBE_POST|VBE_SAVE|UNSURE|RADEON_OFF },
	{ "IBM",			"2891*",		"",	"", VBE_POST|VBE_SAVE|UNSURE|RADEON_OFF },
	// X40
	{ "IBM",			"2369*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"2370*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"2372*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"2382*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"2386*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	// X41
	{ "IBM",			"1864*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"1865*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"2525*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"2526*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"2527*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"2528*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	// X41 Tablet
	{ "IBM",			"1866*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"1867*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "IBM",			"1869*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },

	{ "Samsung Electronics",	"NX05S*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "SHARP Corporation",		"PC-MM20 Series*",	"",	"", VBE_POST|VBE_SAVE|UNSUR=
E },
	{ "Sony Corporation",		"PCG-U101*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },

	{ "TOSHIBA",			"libretto U100*",	"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "TOSHIBA",			"P4000*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "TOSHIBA",			"PORTEGE A100*",	"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "TOSHIBA",			"PORTEGE A200*",	"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "TOSHIBA",			"PORTEGE M200*",	"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "TOSHIBA",			"PORTEGE R200*",	"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "TOSHIBA",			"Satellite 1900*",	"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "TOSHIBA",			"TECRA A2*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "TOSHIBA",			"TECRA A5*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ "TOSHIBA",			"TECRA M2*",		"",	"", VBE_POST|VBE_SAVE|UNSURE },
	{ NULL }
};


-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
