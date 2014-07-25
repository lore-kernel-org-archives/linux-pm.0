From: Robert =?ISO-8859-1?Q?Sch=F6ne?= <robert.schoene@tu-dresden.de>
Subject: Re: PROBLEM: Kernel OOPS and possible system freeze after
 concurrent writing to cpufreq/scaling_governor (Resend)
Date: Fri, 25 Jul 2014 15:19:06 +0200
Message-ID: <1406294346.2399.8.camel@x200t>
References: <1405522398.2348.42.camel@x200t> <1406185912.2406.3.camel@x200t>
	 <CAKohpomo_Qoc-ioC-L-n6z19SLMgCfzebec7pqkq9y86gt61HA@mail.gmail.com>
	 <1406277769.2399.4.camel@x200t>
	 <CAKohpomDkU1nBP4+1EkSdDxQESD+1b6kmaELVfGEifqTL+ZOdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="sha1"; protocol="application/x-pkcs7-signature";
	boundary="=-IVB4zHuFZd7GPxec0kiP"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.zih.tu-dresden.de ([141.30.67.72]:34747 "EHLO
	mailout1.zih.tu-dresden.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759996AbaGYNTL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Jul 2014 09:19:11 -0400
In-Reply-To: <CAKohpomDkU1nBP4+1EkSdDxQESD+1b6kmaELVfGEifqTL+ZOdg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>


--=-IVB4zHuFZd7GPxec0kiP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


> Please run this in your repository:
>=20
> git revert 56d07db
>=20
> save-quit the editor window and try again..

I just did so, but I still get a kernel OOPS.
However, I've been able to get the call trace this time :)


Jul 25 14:52:55 basti kernel: [ 2073.816176] ------------[ cut here ]------=
------
Jul 25 14:52:55 basti kernel: [ 2073.816184] WARNING: CPU: 1 PID: 2458 at d=
rivers/cpufreq/cpufreq_governor.c:261 cpufreq_governor_dbs+0x6d2/0x740()
Jul 25 14:52:55 basti kernel: [ 2073.816186] Modules linked in: nfsv3(E) nf=
sd(E) bnep(E) auth_rpcgss(E) rfcomm(E) bluetooth(E) nfs_acl(E) nfs(E) lockd=
(E) binfmt_misc(E) sunrpc(E) fscache(E) intel_rapl(E) i915(E) x86_pkg_temp_=
thermal(E) intel_powerclamp(E) coretemp(E) snd_
hda_codec_hdmi(E) snd_hda_codec_conexant(E) snd_hda_codec_generic(E) kvm_in=
tel(E) snd_hda_intel(E) kvm(E) video(E) snd_hda_controller(E) drm_kms_helpe=
r(E) snd_hda_codec(E) crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_int=
el(E) snd_hwdep(E) snd_pcm(E) snd_timer(E) drm(
E) snd(E) aesni_intel(E) aes_x86_64(E) ppdev(E) mei_me(E) gpio_ich(E) parpo=
rt_pc(E) serio_raw(E) mac_hid(E) lpc_ich(E) lp(E) i2c_algo_bit(E) lrw(E) so=
undcore(E) mei(E) parport(E) gf128mul(E) glue_helper(E) ablk_helper(E) cryp=
td(E) tpm_infineon(E) psmouse(E) ahci(E) e1000e
(E) libahci(E) ptp(E) pps_core(E)
Jul 25 14:52:55 basti kernel: [ 2073.816224] CPU: 1 PID: 2458 Comm: tee Tai=
nted: G           OE 3.16.0-rc6+ #1
Jul 25 14:52:55 basti kernel: [ 2073.816225] Hardware name: FUJITSU ESPRIMO=
 P700/D3061-A1, BIOS V4.6.4.0 R1.12.0 for D3061-A1x 07/04/2011
Jul 25 14:52:55 basti kernel: [ 2073.816226]  0000000000000009 ffff8800ae40=
3b78 ffffffff8173b0bf 0000000000000000
Jul 25 14:52:55 basti kernel: [ 2073.816229]  ffff8800ae403bb0 ffffffff8106=
c82d 0000000000000000 ffff88022fa27000
Jul 25 14:52:55 basti kernel: [ 2073.816231]  0000000000000005 000000000000=
0002 ffffffff81cd5d00 ffff8800ae403bc0
Jul 25 14:52:55 basti kernel: [ 2073.816234] Call Trace:
Jul 25 14:52:55 basti kernel: [ 2073.816239]  [<ffffffff8173b0bf>] dump_sta=
ck+0x45/0x56
Jul 25 14:52:55 basti kernel: [ 2073.816243]  [<ffffffff8106c82d>] warn_slo=
wpath_common+0x7d/0xa0
Jul 25 14:52:55 basti kernel: [ 2073.816246]  [<ffffffff8106c90a>] warn_slo=
wpath_null+0x1a/0x20
Jul 25 14:52:55 basti kernel: [ 2073.816256]  [<ffffffff815e4a12>] cpufreq_=
governor_dbs+0x6d2/0x740
Jul 25 14:52:55 basti kernel: [ 2073.816266]  [<ffffffff810941fc>] ? notifi=
er_call_chain+0x4c/0x70
Jul 25 14:52:55 basti kernel: [ 2073.816269]  [<ffffffff815e2757>] od_cpufr=
eq_governor_dbs+0x17/0x20
Jul 25 14:52:55 basti kernel: [ 2073.816272]  [<ffffffff815dea50>] __cpufre=
q_governor+0xb0/0x2a0
Jul 25 14:52:55 basti kernel: [ 2073.816275]  [<ffffffff815ded8c>] cpufreq_=
set_policy+0x14c/0x2f0
Jul 25 14:52:55 basti kernel: [ 2073.816277]  [<ffffffff815df796>] store_sc=
aling_governor+0x96/0xf0
Jul 25 14:52:55 basti kernel: [ 2073.816280]  [<ffffffff815df100>] ? cpufre=
q_update_policy+0x1d0/0x1d0
Jul 25 14:52:55 basti kernel: [ 2073.816284]  [<ffffffff815de3c9>] store+0x=
79/0xc0
Jul 25 14:52:55 basti kernel: [ 2073.816288]  [<ffffffff81245bed>] sysfs_kf=
_write+0x3d/0x50
Jul 25 14:52:55 basti kernel: [ 2073.816290]  [<ffffffff81245120>] kernfs_f=
op_write+0xe0/0x160
Jul 25 14:52:55 basti kernel: [ 2073.816292]  [<ffffffff811d00d7>] vfs_writ=
e+0xb7/0x1f0
Jul 25 14:52:55 basti kernel: [ 2073.816294]  [<ffffffff811d0c76>] SyS_writ=
e+0x46/0xb0
Jul 25 14:52:55 basti kernel: [ 2073.816296]  [<ffffffff817439ff>] tracesys=
+0xe1/0xe6
Jul 25 14:52:55 basti kernel: [ 2073.816297] ---[ end trace a2dad7e42b22c79=
6 ]---
Jul 25 14:52:55 basti kernel: [ 2073.816702] BUG: unable to handle kernel N=
ULL pointer dereference at           (null)
Jul 25 14:52:55 basti kernel: [ 2073.816731] IP: [<ffffffff815e4395>] cpufr=
eq_governor_dbs+0x55/0x740
Jul 25 14:52:55 basti kernel: [ 2073.816751] PGD 36a05067 PUD b47df067 PMD =
0=20
Jul 25 14:52:55 basti kernel: [ 2073.816766] Oops: 0000 [#1] SMP=20
Jul 25 14:52:55 basti kernel: [ 2073.816779] Modules linked in: nfsv3(E) nf=
sd(E) bnep(E) auth_rpcgss(E) rfcomm(E) bluetooth(E) nfs_acl(E) nfs(E) lockd=
(E) binfmt_misc(E) sunrpc(E) fscache(E) intel_rapl(E) i915(E) x86_pkg_temp_=
thermal(E) intel_powerclamp(E) coretemp(E) snd_hda_codec_hdmi(E) snd_hda_co=
dec_conexant(E) snd_hda_codec_generic(E) kvm_intel(E) snd_hda_intel(E) kvm(=
E) video(E) snd_hda_controller(E) drm_kms_helper(E) snd_hda_codec(E) crct10=
dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) snd_hwdep(E) snd_pcm(E=
) snd_timer(E) drm(E) snd(E) aesni_intel(E) aes_x86_64(E) ppdev(E) mei_me(E=
) gpio_ich(E) parport_pc(E) serio_raw(E) mac_hid(E) lpc_ich(E) lp(E) i2c_al=
go_bit(E) lrw(E) soundcore(E) mei(E) parport(E) gf128mul(E) glue_helper(E) =
ablk_helper(E) cryptd(E) tpm_infineon(E) psmouse(E) ahci(E) e1000e(E) libah=
ci(E) ptp(E) pps_core(E)
Jul 25 14:52:55 basti kernel: [ 2073.817023] CPU: 1 PID: 2458 Comm: tee Tai=
nted: G        W  OE 3.16.0-rc6+ #1
Jul 25 14:52:55 basti kernel: [ 2073.817041] Hardware name: FUJITSU ESPRIMO=
 P700/D3061-A1, BIOS V4.6.4.0 R1.12.0 for D3061-A1x 07/04/2011
Jul 25 14:52:55 basti kernel: [ 2073.817065] task: ffff8800b53db240 ti: fff=
f8800ae400000 task.ti: ffff8800ae400000
Jul 25 14:52:55 basti kernel: [ 2073.817085] RIP: 0010:[<ffffffff815e4395>]=
  [<ffffffff815e4395>] cpufreq_governor_dbs+0x55/0x740
Jul 25 14:52:55 basti kernel: [ 2073.817110] RSP: 0018:ffff8800ae403bd0  EF=
LAGS: 00010293
Jul 25 14:52:55 basti kernel: [ 2073.817124] RAX: 0000000000000024 RBX: 000=
0000000000000 RCX: 0000000000000006
Jul 25 14:52:55 basti kernel: [ 2073.817142] RDX: 0000000000000007 RSI: 000=
0000000000000 RDI: 0000000000000009
Jul 25 14:52:55 basti kernel: [ 2073.817160] RBP: ffff8800ae403c40 R08: 000=
0000000000086 R09: 000000000000036e
Jul 25 14:52:55 basti kernel: [ 2073.817178] R10: 0000000000000000 R11: fff=
f8800ae4038a6 R12: ffff88022fa27000
Jul 25 14:52:55 basti kernel: [ 2073.817196] R13: 0000000000000005 R14: 000=
0000000000002 R15: ffffffff81cd5d00
Jul 25 14:52:55 basti kernel: [ 2073.817214] FS:  00002b63742dab80(0000) GS=
:ffff88023e240000(0000) knlGS:0000000000000000
Jul 25 14:52:55 basti kernel: [ 2073.817235] CS:  0010 DS: 0000 ES: 0000 CR=
0: 0000000080050033
Jul 25 14:52:55 basti kernel: [ 2073.817250] CR2: 00002ba7f5d7f300 CR3: 000=
00000b4ce8000 CR4: 00000000000407e0
Jul 25 14:52:55 basti kernel: [ 2073.817268] Stack:
Jul 25 14:52:55 basti kernel: [ 2073.817274]  ffff8800ae403cc8 00000000ffff=
fffd 0000000000000000 0000000000000002
Jul 25 14:52:55 basti kernel: [ 2073.817297]  ffff8800ae403c28 ffffffff8109=
41fc ffffffff81cd5720 0000000000000000
Jul 25 14:52:55 basti kernel: [ 2073.817319]  0000000000000002 ffff88022fa2=
7000 0000000000000002 ffffffff81cd5d60
Jul 25 14:52:55 basti kernel: [ 2073.817342] Call Trace:
Jul 25 14:52:55 basti kernel: [ 2073.817351]  [<ffffffff810941fc>] ? notifi=
er_call_chain+0x4c/0x70
Jul 25 14:52:55 basti kernel: [ 2073.817367]  [<ffffffff815e2757>] od_cpufr=
eq_governor_dbs+0x17/0x20
Jul 25 14:52:55 basti kernel: [ 2073.817384]  [<ffffffff815dea50>] __cpufre=
q_governor+0xb0/0x2a0
Jul 25 14:52:55 basti kernel: [ 2073.817401]  [<ffffffff815ded8c>] cpufreq_=
set_policy+0x14c/0x2f0
Jul 25 14:52:55 basti kernel: [ 2073.817417]  [<ffffffff815df796>] store_sc=
aling_governor+0x96/0xf0
Jul 25 14:52:55 basti kernel: [ 2073.817434]  [<ffffffff815df100>] ? cpufre=
q_update_policy+0x1d0/0x1d0
Jul 25 14:52:55 basti kernel: [ 2073.817452]  [<ffffffff815de3c9>] store+0x=
79/0xc0
Jul 25 14:52:55 basti kernel: [ 2073.817467]  [<ffffffff81245bed>] sysfs_kf=
_write+0x3d/0x50
Jul 25 14:52:55 basti kernel: [ 2073.817482]  [<ffffffff81245120>] kernfs_f=
op_write+0xe0/0x160
Jul 25 14:52:55 basti kernel: [ 2073.817498]  [<ffffffff811d00d7>] vfs_writ=
e+0xb7/0x1f0
Jul 25 14:52:55 basti kernel: [ 2073.817513]  [<ffffffff811d0c76>] SyS_writ=
e+0x46/0xb0
Jul 25 14:52:55 basti kernel: [ 2073.817527]  [<ffffffff817439ff>] tracesys=
+0xe1/0xe6
Jul 25 14:52:55 basti kernel: [ 2073.817540] Code: 0f 84 60 02 00 00 49 8b =
9c 24 88 00 00 00 48 85 db 0f 84 76 06 00 00 41 83 fe 04 0f 84 85 02 00 00 =
41 83 fe 05 0f 84 4b 02 00 00 <48> 8b 03 44 89 ef ff 50 20 48 89 45 c0 48 8=
b 03 83 38 01 0f 84=20
Jul 25 14:52:55 basti kernel: [ 2073.817666] RIP  [<ffffffff815e4395>] cpuf=
req_governor_dbs+0x55/0x740
Jul 25 14:52:55 basti kernel: [ 2073.817685]  RSP <ffff8800ae403bd0>
Jul 25 14:52:55 basti kernel: [ 2073.818467] CR2: 0000000000000000
Jul 25 14:52:55 basti kernel: [ 2073.825744] ---[ end trace a2dad7e42b22c79=
7 ]---




--=20

Dipl.-Inf. Robert Schoene
Computer Scientist - R&D Energy Efficient Computing

Technische Universitaet Dresden
Center for Information Services and High Performance Computing
Distributed and Data Intensive Computing
01062 Dresden
Tel.: +49 (351) 463-42483
Fax : +49 (351) 463-37773
E-Mail: Robert.Schoene@tu-dresden.de

--=-IVB4zHuFZd7GPxec0kiP
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIVMTCCBHQw
ggNcoAMCAQICCQCJkBEVWD6HmzANBgkqhkiG9w0BAQsFADBxMQswCQYDVQQGEwJERTEcMBoGA1UE
ChMTRGV1dHNjaGUgVGVsZWtvbSBBRzEfMB0GA1UECxMWVC1UZWxlU2VjIFRydXN0IENlbnRlcjEj
MCEGA1UEAxMaRGV1dHNjaGUgVGVsZWtvbSBSb290IENBIDIwHhcNMTQwMjExMTMxMTQ1WhcNMTkw
NzA5MjM1OTAwWjBaMQswCQYDVQQGEwJERTETMBEGA1UEChMKREZOLVZlcmVpbjEQMA4GA1UECxMH
REZOLVBLSTEkMCIGA1UEAxMbREZOLVZlcmVpbiBQQ0EgR2xvYmFsIC0gRzAxMIIBIjANBgkqhkiG
9w0BAQEFAAOCAQ8AMIIBCgKCAQEA6ZvDZ4X5Da71jVTDllA1PWLpbkztlNcAW5UidNQg6zSP1uzA
MQQLmYHiphTSUqAoI4SLdIkEXlvg4njBeMsWyyg1OXstkEXQ7aAAeny/Sg4bAMOG6VwrMRF7DPOC
JEOMHDiLamgAmu7cT3ir0sYTm3at7t4m6O8Br3QPwQmi9mvOvdPNFDBP9eXjpMhim4IaAycwDQJl
YE3t0QkjKpY1WCfTdsZxtpAdxO3/NYZ9bzOz2w/FEcKKg6GUXUFr2NIQ9Uz9ylGs2b3vkoO72uuL
FlZWQ8/h1RM9ph8nMM1JVNvJEzSacXXFbOqnC5j5IZ0nrz6jOTlIaoytyZn7wxLyvQIDAQABo4IB
JDCCASAwDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBRJt8bP6D0ff+pEexMp9/EKcD7eZDAfBgNV
HSMEGDAWgBQxw3kbuvVT1xfgiXotF2wKsyudMzASBgNVHRMBAf8ECDAGAQH/AgECMD8GA1UdHwQ4
MDYwNKAyoDCGLmh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL3JsL0RUX1JPT1RfQ0FfMi5jcmww
eQYIKwYBBQUHAQEEbTBrMCwGCCsGAQUFBzABhiBodHRwOi8vb2NzcDAzMzYudGVsZXNlYy5kZS9v
Y3NwcjA7BggrBgEFBQcwAoYvaHR0cDovL29jc3AwMzM2LnRlbGVzZWMuZGUvY3J0L0RUX1JPT1Rf
Q0FfMi5jZXIwDQYJKoZIhvcNAQELBQADggEBACwvqeBeQy8FcNxRlXVdgI47DMFjWFSBMIOcXalR
h8m21w8runhIJGBCzPGi4jPhMh4ym1ETlXnGtazQJO0YFLwvKuovq7ITrEkdXgALBBhqmmXU6Ec1
vK7t33S22PGAUGWgxtojm41TR8psu0DJlV1OYHor5LtmQFWvtjPB6iMhbvxUnd0zQm5Ma9Xkw/Lq
BrdaMmoyRXS2tW/+6v8cY6q7iNH4WK8gfo+///b3OHeLGrZQP609R3lGw1e0F2KHvZ6jNiUHaCSq
IvL2rynsN6UUma66AWCGdS1hFbp4loe1ks/hUJGeWToV7J5axob8KD5mutTZNa+tPEkihYfub48w
ggVhMIIESaADAgECAgcXpCR5aFyOMA0GCSqGSIb3DQEBCwUAMFoxCzAJBgNVBAYTAkRFMRMwEQYD
VQQKEwpERk4tVmVyZWluMRAwDgYDVQQLEwdERk4tUEtJMSQwIgYDVQQDExtERk4tVmVyZWluIFBD
QSBHbG9iYWwgLSBHMDEwHhcNMTQwNTI3MTQ1MzI5WhcNMTkwNzA5MjM1OTAwWjCBhTELMAkGA1UE
BhMCREUxKDAmBgNVBAoTH1RlY2huaXNjaGUgVW5pdmVyc2l0YWV0IERyZXNkZW4xDDAKBgNVBAsT
A1pJSDEcMBoGA1UEAxMTVFUgRHJlc2RlbiBDQSAtIEcwMjEgMB4GCSqGSIb3DQEJARYRcGtpQHR1
LWRyZXNkZW4uZGUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDBDh6T80T27NAn91B6
YQsENBWT/LEfbGPagOzhM1w1Cjx3ICCilYCgJeIPQmBZT9RalxxF2z2OGDPcRTuqcaFPkgtdGaw1
BFEIX+kGe3Itz2GlaKLPnQBHwcp+ODj8OdgvD4wZqYkvsjaDx1ck2spHHVxLEh/7ybexJL3f1zat
qPJkK2fJuOeeUz3Ip74sPqhKn3QA5Q5E4JUHlvh3l4TDFrbmEIMntRqrJ+LaG2JCQ2G9hfEUvxeo
3Zr6y88IdG+d7Hbp+XJkZYoOenVItm9z+atzo+NBxdmW8nD00xJAG52xQSwN4HR+qtj0CcnMtj41
zXv6ul2E7ltRubqNM3snAgMBAAGjggH+MIIB+jASBgNVHRMBAf8ECDAGAQH/AgEBMA4GA1UdDwEB
/wQEAwIBBjARBgNVHSAECjAIMAYGBFUdIAAwHQYDVR0OBBYEFMUrU5MXg8n1RkLtQ2rftoCmR/Lg
MB8GA1UdIwQYMBaAFEm3xs/oPR9/6kR7Eyn38QpwPt5kMBwGA1UdEQQVMBOBEXBraUB0dS1kcmVz
ZGVuLmRlMIGIBgNVHR8EgYAwfjA9oDugOYY3aHR0cDovL2NkcDEucGNhLmRmbi5kZS9nbG9iYWwt
cm9vdC1jYS9wdWIvY3JsL2NhY3JsLmNybDA9oDugOYY3aHR0cDovL2NkcDIucGNhLmRmbi5kZS9n
bG9iYWwtcm9vdC1jYS9wdWIvY3JsL2NhY3JsLmNybDCB1wYIKwYBBQUHAQEEgcowgccwMwYIKwYB
BQUHMAGGJ2h0dHA6Ly9vY3NwLnBjYS5kZm4uZGUvT0NTUC1TZXJ2ZXIvT0NTUDBHBggrBgEFBQcw
AoY7aHR0cDovL2NkcDEucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1jYS9wdWIvY2FjZXJ0L2NhY2Vy
dC5jcnQwRwYIKwYBBQUHMAKGO2h0dHA6Ly9jZHAyLnBjYS5kZm4uZGUvZ2xvYmFsLXJvb3QtY2Ev
cHViL2NhY2VydC9jYWNlcnQuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQCJhMBD4Oh4PXhRwECrWgom
DDnELDDFh4FN1e2g0gYbKLg/kA0gw6RKImh4GhTRAbENxW2My+tHaKFjtwQdBaanilk4DN581jqx
jo37jPEwDmNNzT8U4ssiwmkMD2bWM2vTcc7lDj2g7w+sRzIJ8zi1AtCV43bJT8xBVj0PQpFuqYVv
YzgMq+KNtGn4YyiBAMyDY1EzPEgtOovN7sqXb3jGDa71gqdHWIKf9orfDWCZ/Y8d+Y+rSqtBAHj0
fnAzjnIgtJvUIif+Afx/4Rvxy0MHj3q6uHhPFcZ9QBPm+vxX2nWXEMlJcf1A/Igdah5hUpkmAQIU
UJso8QbE4gXBS/BPMIIFpjCCBI6gAwIBAgIHFSZS13FEIzANBgkqhkiG9w0BAQUFADCBhTELMAkG
A1UEBhMCREUxKDAmBgNVBAoTH1RlY2huaXNjaGUgVW5pdmVyc2l0YWV0IERyZXNkZW4xDDAKBgNV
BAsTA1pJSDEcMBoGA1UEAxMTVFUgRHJlc2RlbiBDQSAtIEcwMjEgMB4GCSqGSIb3DQEJARYRcGtp
QHR1LWRyZXNkZW4uZGUwHhcNMTMwMTI4MTk0NTExWhcNMTYwMTI4MTk0NTExWjBeMQswCQYDVQQG
EwJERTEoMCYGA1UEChMfVGVjaG5pc2NoZSBVbml2ZXJzaXRhZXQgRHJlc2RlbjEMMAoGA1UECxMD
WklIMRcwFQYDVQQDEw5Sb2JlcnQgU2Nob2VuZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBAMWGkfZe+dO1uZb8XQk9wqyOI12lOwRONx9g5A64xUJ7BCH7PocFLf3TKMBhRyYTy0w3dHOd
B6SJrEfMPm/ioe7BhTL7Eejm3AEThAXAcox4oE8467c7zljb1dmImMwjOu4YzhoSHtKaOX5l6M6z
+QDeA9bdQw3oHRCm2uPYmIHfJJTlXNl/nfEsbdInofFjKG3nU9sZlPNUtpxrBc2p8UJw4TERIi2Z
YWc1NzZRffJjc9LWDGYN32hLyV/M/bDj52/UdqexORNj6KB6fFwjFYXekdc5KZecUKtrkc7mIn3k
nCnOwQsHhjmBHK0H6AEykrMKkbieKFA+7rZ6IVBAPksCAwEAAaOCAj8wggI7MC8GA1UdIAQoMCYw
EQYPKwYBBAGBrSGCLAEBBAMAMBEGDysGAQQBga0hgiwCAQQDADAJBgNVHRMEAjAAMAsGA1UdDwQE
AwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwHQYDVR0OBBYEFPnXXpzeLkF3GQNu
qwqw7nBiTM3XMB8GA1UdIwQYMBaAFMUrU5MXg8n1RkLtQ2rftoCmR/LgMCcGA1UdEQQgMB6BHHJv
YmVydC5zY2hvZW5lQHR1LWRyZXNkZW4uZGUwgYsGA1UdHwSBgzCBgDA+oDygOoY4aHR0cDovL2Nk
cDEucGNhLmRmbi5kZS90dS1kcmVzZGVuLWNhL3B1Yi9jcmwvZ19jYWNybC5jcmwwPqA8oDqGOGh0
dHA6Ly9jZHAyLnBjYS5kZm4uZGUvdHUtZHJlc2Rlbi1jYS9wdWIvY3JsL2dfY2FjcmwuY3JsMIHZ
BggrBgEFBQcBAQSBzDCByTAzBggrBgEFBQcwAYYnaHR0cDovL29jc3AucGNhLmRmbi5kZS9PQ1NQ
LVNlcnZlci9PQ1NQMEgGCCsGAQUFBzAChjxodHRwOi8vY2RwMS5wY2EuZGZuLmRlL3R1LWRyZXNk
ZW4tY2EvcHViL2NhY2VydC9nX2NhY2VydC5jcnQwSAYIKwYBBQUHMAKGPGh0dHA6Ly9jZHAyLnBj
YS5kZm4uZGUvdHUtZHJlc2Rlbi1jYS9wdWIvY2FjZXJ0L2dfY2FjZXJ0LmNydDANBgkqhkiG9w0B
AQUFAAOCAQEAcFQx6L5b5YOHN0yL6DiX9Sa3URExEaEonxp9S3Q9Nu8NDp/1h62y5KYxLudQEscU
zUdmAdPm7HRgWzdv/ogwtL94o0AkihfdAqZrXJERWsbNwerS2QgYoYmj2elFCyBt42MaJdg7beVh
PJVet1MDHTkKUM5uIRCLbs21oEoyJq4Lm6cC+xob6rYWRJaZIhys41CtT5oHroSbCPnlOrVruckL
wfJ4uaHGDdoIohP0bt/Id4sQ7o3GGdAQh64bevDtOjK2uN1mxVN6jpxdkgV2AwNQEygtFEL7kcQo
07+vL3AirtHcAk0OMUFmTwjb0ngEgiTBcin+macAx5CtcpQzzTCCBaYwggSOoAMCAQICBxUmUtdx
RCMwDQYJKoZIhvcNAQEFBQAwgYUxCzAJBgNVBAYTAkRFMSgwJgYDVQQKEx9UZWNobmlzY2hlIFVu
aXZlcnNpdGFldCBEcmVzZGVuMQwwCgYDVQQLEwNaSUgxHDAaBgNVBAMTE1RVIERyZXNkZW4gQ0Eg
LSBHMDIxIDAeBgkqhkiG9w0BCQEWEXBraUB0dS1kcmVzZGVuLmRlMB4XDTEzMDEyODE5NDUxMVoX
DTE2MDEyODE5NDUxMVowXjELMAkGA1UEBhMCREUxKDAmBgNVBAoTH1RlY2huaXNjaGUgVW5pdmVy
c2l0YWV0IERyZXNkZW4xDDAKBgNVBAsTA1pJSDEXMBUGA1UEAxMOUm9iZXJ0IFNjaG9lbmUwggEi
MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDFhpH2XvnTtbmW/F0JPcKsjiNdpTsETjcfYOQO
uMVCewQh+z6HBS390yjAYUcmE8tMN3RznQekiaxHzD5v4qHuwYUy+xHo5twBE4QFwHKMeKBPOOu3
O85Y29XZiJjMIzruGM4aEh7Smjl+ZejOs/kA3gPW3UMN6B0Qptrj2JiB3ySU5VzZf53xLG3SJ6Hx
Yyht51PbGZTzVLacawXNqfFCcOExESItmWFnNTc2UX3yY3PS1gxmDd9oS8lfzP2w4+dv1HansTkT
Y+igenxcIxWF3pHXOSmXnFCra5HO5iJ95JwpzsELB4Y5gRytB+gBMpKzCpG4nihQPu62eiFQQD5L
AgMBAAGjggI/MIICOzAvBgNVHSAEKDAmMBEGDysGAQQBga0hgiwBAQQDADARBg8rBgEEAYGtIYIs
AgEEAwAwCQYDVR0TBAIwADALBgNVHQ8EBAMCBeAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUF
BwMEMB0GA1UdDgQWBBT5116c3i5BdxkDbqsKsO5wYkzN1zAfBgNVHSMEGDAWgBTFK1OTF4PJ9UZC
7UNq37aApkfy4DAnBgNVHREEIDAegRxyb2JlcnQuc2Nob2VuZUB0dS1kcmVzZGVuLmRlMIGLBgNV
HR8EgYMwgYAwPqA8oDqGOGh0dHA6Ly9jZHAxLnBjYS5kZm4uZGUvdHUtZHJlc2Rlbi1jYS9wdWIv
Y3JsL2dfY2FjcmwuY3JsMD6gPKA6hjhodHRwOi8vY2RwMi5wY2EuZGZuLmRlL3R1LWRyZXNkZW4t
Y2EvcHViL2NybC9nX2NhY3JsLmNybDCB2QYIKwYBBQUHAQEEgcwwgckwMwYIKwYBBQUHMAGGJ2h0
dHA6Ly9vY3NwLnBjYS5kZm4uZGUvT0NTUC1TZXJ2ZXIvT0NTUDBIBggrBgEFBQcwAoY8aHR0cDov
L2NkcDEucGNhLmRmbi5kZS90dS1kcmVzZGVuLWNhL3B1Yi9jYWNlcnQvZ19jYWNlcnQuY3J0MEgG
CCsGAQUFBzAChjxodHRwOi8vY2RwMi5wY2EuZGZuLmRlL3R1LWRyZXNkZW4tY2EvcHViL2NhY2Vy
dC9nX2NhY2VydC5jcnQwDQYJKoZIhvcNAQEFBQADggEBAHBUMei+W+WDhzdMi+g4l/Umt1ERMRGh
KJ8afUt0PTbvDQ6f9YetsuSmMS7nUBLHFM1HZgHT5ux0YFs3b/6IMLS/eKNAJIoX3QKma1yREVrG
zcHq0tkIGKGJo9npRQsgbeNjGiXYO23lYTyVXrdTAx05ClDObiEQi27NtaBKMiauC5unAvsaG+q2
FkSWmSIcrONQrU+aB66Emwj55Tq1a7nJC8HyeLmhxg3aCKIT9G7fyHeLEO6NxhnQEIeuG3rw7Toy
trjdZsVTeo6cXZIFdgMDUBMoLRRC+5HEKNO/ry9wIq7R3AJNDjFBZk8I29J4BIIkwXIp/pmnAMeQ
rXKUM80xggNmMIIDYgIBATCBkTCBhTELMAkGA1UEBhMCREUxKDAmBgNVBAoTH1RlY2huaXNjaGUg
VW5pdmVyc2l0YWV0IERyZXNkZW4xDDAKBgNVBAsTA1pJSDEcMBoGA1UEAxMTVFUgRHJlc2RlbiBD
QSAtIEcwMjEgMB4GCSqGSIb3DQEJARYRcGtpQHR1LWRyZXNkZW4uZGUCBxUmUtdxRCMwCQYFKw4D
AhoFAKCCAakwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTQwNzI1
MTMxOTA2WjAjBgkqhkiG9w0BCQQxFgQUzWfnnAlP2IrGxo3cnjn7hdiBQpgwgaIGCSsGAQQBgjcQ
BDGBlDCBkTCBhTELMAkGA1UEBhMCREUxKDAmBgNVBAoTH1RlY2huaXNjaGUgVW5pdmVyc2l0YWV0
IERyZXNkZW4xDDAKBgNVBAsTA1pJSDEcMBoGA1UEAxMTVFUgRHJlc2RlbiBDQSAtIEcwMjEgMB4G
CSqGSIb3DQEJARYRcGtpQHR1LWRyZXNkZW4uZGUCBxUmUtdxRCMwgaQGCyqGSIb3DQEJEAILMYGU
oIGRMIGFMQswCQYDVQQGEwJERTEoMCYGA1UEChMfVGVjaG5pc2NoZSBVbml2ZXJzaXRhZXQgRHJl
c2RlbjEMMAoGA1UECxMDWklIMRwwGgYDVQQDExNUVSBEcmVzZGVuIENBIC0gRzAyMSAwHgYJKoZI
hvcNAQkBFhFwa2lAdHUtZHJlc2Rlbi5kZQIHFSZS13FEIzANBgkqhkiG9w0BAQEFAASCAQCUJuEb
XOmb45f0V1zL/WcMFEpEh3rldqgRbmST7QFuIs2xQVXKI/tb7K/7h+vAhPjHd0XiR45PvKIvFsbu
SOLp7YoQneLMwwHmkgLMMs8liquB2cvY6qgH1QuQ/E4G9z74yXHoLxuX2Cwzp3Sqh2imCPvtoQUu
b+4gl6CWpMJTjRR5q4l7J4G7U9+y6SODmni+j7zXVEDfFDLrf8qxZMrfhD7W9+sJFpm/zdxUpP4w
+nSa8ljZ1c0ztZSQ3/Grpyy4uq2DukgO0vczpHwQx1WAeejgbrhYuplX3JWM3R7SKJr0/l/bRxYv
pDhR8JTMCDLpdVLGquNB1p6NUUbYGWz5AAAAAAAA


--=-IVB4zHuFZd7GPxec0kiP--

