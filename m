From: "Mansoor, Illyas" <illyas.mansoor@intel.com>
Subject: Re: Question regarding completion signal in S3 flow
Date: Thu, 26 Jan 2012 15:19:34 +0000
Message-ID: <810586B7581CC8469141DADEBC371912057F41@BGSMSX102.gar.corp.intel.com>
References: <810586B7581CC8469141DADEBC371912057D42@BGSMSX102.gar.corp.intel.com>
	<Pine.LNX.4.44L0.1201260956370.1386-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3268851523970860731=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1201260956370.1386-100000@iolanthe.rowland.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

--===============3268851523970860731==
Content-Language: en-US
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=SHA1; boundary="----=_NextPart_000_0027_01CCDC6B.FF930BA0"

------=_NextPart_000_0027_01CCDC6B.FF930BA0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

> > I have question related to suspend flow and completion signal:
> >
> > Is it possible that a completion signal could be missed in S3 flow
> > after processes are frozen?
> 
> What do you mean by "completion signal"?

In our case we have an interrupt that signals completion of the interrupt using
complete()
For a waiting thread.

> 
> > The scenario is:
> >
> > Suspend_thread->...->dpm_suspend_start->suspend-
> >Wait_for_completion_t
> > imeout->do
> > es not receive signal and times out
> 
> dpm_suspend_start doesn't run until processes are frozen, and frozen processes
> cannot be waiting for a completion.  Therefore this can't happen.
> 
> > Interrupt->complete->
> >
> > This happens very rare, there are other reason why
> > wait_for_completion_times out like interrupt not received but I just
> > want To make sure if completion signal is not lost during S3.
> 
> Of course it's possible that interrupts will not be delivered while the
computer is
> suspending or suspended.  Those interrupts should be delivered later, when the
> computer wakes up again.
> 
Our interrupt is configured with IRQ_NO_SUSPEND so we expect interrupts during 
Suspend also.

So here is what I'm seeing in the panic logs:

<4>[ 7960.661939] Call Trace:
<4>[ 7960.661953]  [<c12384a5>] ? sub_preempt_count+0x85/0xc0
<4>[ 7960.661965]  [<c12735b5>] refrigerator+0xa5/0x160
<4>[ 7960.661977]  [<c125f64d>] get_signal_to_deliver+0x9ad/0xdc0
<4>[ 7960.661991]  [<c120257b>] do_signal+0x6b/0xa20
<4>[ 7960.662003]  [<c186ffbd>] ? schedule_hrtimeout_range+0x1cd/0x220
<4>[ 7960.662018]  [<c122d4a4>] ? pmu_sc_irq+0x364/0x3d0 <==============This is
where in the interrupt we signal completion using complete()
<4>[ 7960.662030]  [<c18715f3>] ? _raw_spin_unlock_irqrestore+0x23/0x50
<4>[ 7960.662043]  [<c12384a5>] ? sub_preempt_count+0x85/0xc0
<4>[ 7960.662056]  [<c134c162>] ? sys_epoll_wait+0x72/0x300
<4>[ 7960.662069]  [<c1242c40>] ? default_wake_function+0x0/0x20
<4>[ 7960.662082]  [<c1202f85>] do_notify_resume+0x55/0x90
<4>[ 7960.662094]  [<c1871e99>] work_notifysig+0x9/0x1


<6>[ 7960.380768] suspend         R running      0    19      2 0x00000000
<4>[ 7960.380780]  f78e3c94 00000000 c1204760 f78e3c8c c12047eb f78e3c94
00000000 f78e3c04
<4>[ 7960.380800]  00000004 00000000 00030002 c1852942 00000001 00000001
00000282 f78e3c5c
<4>[ 7960.380820]  f78e3c30 c12384a5 00000282 f78e3c3c c18715f3 f7868000
f78e3c84 c186eebc
<4>[ 7960.380840] Call Trace:
<4>[ 7960.380850]  [<c1204760>] ? do_invalid_op+0x0/0xb0
<4>[ 7960.380862]  [<c12047eb>] ? do_invalid_op+0x8b/0xb0
<4>[ 7960.380875]  [<c1852942>] ? pmu_pci_set_power_state+0x322/0x6e0 <==== here
is where wait_for_completion_timeout call BUG() after timeout.
<4>[ 7960.380888]  [<c12384a5>] ? sub_preempt_count+0x85/0xc0
<4>[ 7960.380901]  [<c18715f3>] ? _raw_spin_unlock_irqrestore+0x23/0x50
<4>[ 7960.380913]  [<c186eebc>] ? schedule_timeout+0x1dc/0x430
<4>[ 7960.380926]  [<c1204760>] ? do_invalid_op+0x0/0xb0
<4>[ 7960.380937]  [<c14b916c>] ? trace_hardirqs_off_thunk+0xc/0x10
<4>[ 7960.380950]  [<c187244b>] ? error_code+0x6b/0x70
<4>[ 7960.380961]  [<c186dd96>] ? wait_for_common+0x96/0x120
<4>[ 7960.380973]  [<c1204760>] ? do_invalid_op+0x0/0xb0
<4>[ 7960.380985]  [<c1852942>] ? pmu_pci_set_power_state+0x322/0x6e0
<4>[ 7960.380998]  [<c14b502a>] ? put_dec+0x2a/0xa0
<4>[ 7960.381011]  [<c14b502a>] ? put_dec+0x2a/0xa0
<4>[ 7960.381025]  [<c12384a5>] ? sub_preempt_count+0x85/0xc0
<4>[ 7960.381038]  [<c14cee6e>] ? pci_platform_power_transition+0x3e/0xa0
<4>[ 7960.381051]  [<c18715f3>] ? _raw_spin_unlock_irqrestore+0x23/0x50
<4>[ 7960.381064]  [<c14cf5df>] ? pci_set_power_state+0x3f/0x2c0
<4>[ 7960.381077]  [<c14ced7c>] ? pci_update_current_state+0x3c/0x50
<4>[ 7960.381090]  [<c14d180e>] ? pci_pm_runtime_resume+0x5e/0xa0
<4>[ 7960.381102]  [<c12384a5>] ? sub_preempt_count+0x85/0xc0
<4>[ 7960.381114]  [<c14d17b0>] ? pci_pm_runtime_resume+0x0/0xa0
<4>[ 7960.381126]  [<c1554d7b>] ? rpm_callback+0x3b/0x70
<4>[ 7960.381137]  [<c155577c>] ? rpm_resume+0x37c/0x5c0
<4>[ 7960.381150]  [<c124923b>] ? release_console_sem+0x37b/0x3c0
<4>[ 7960.381164]  [<c1238593>] ? add_preempt_count+0xb3/0xf0
<4>[ 7960.381176]  [<c1556609>] ? __pm_runtime_resume+0x49/0xc0
<4>[ 7960.381189]  [<c14d1b71>] ? pci_pm_prepare+0x21/0x60
<4>[ 7960.381200]  [<c1553947>] ? dpm_suspend_start+0x137/0x7d0
<4>[ 7960.381213]  [<c12384a5>] ? sub_preempt_count+0x85/0xc0
<4>[ 7960.381225]  [<c18715f3>] ? _raw_spin_unlock_irqrestore+0x23/0x50
<4>[ 7960.381237]  [<c126f548>] ? up+0x28/0x40
<4>[ 7960.381250]  [<c1288f13>] ? suspend_devices_and_enter+0x73/0x1d0
<4>[ 7960.381262]  [<c1289196>] ? enter_state+0x126/0x1e0
<4>[ 7960.381273]  [<c1289277>] ? pm_suspend+0x27/0x70
<4>[ 7960.381285]  [<c128acba>] ? suspend+0x8a/0x160
<4>[ 7960.381296]  [<c186e445>] ? schedule+0x545/0x9e0
<4>[ 7960.381310]  [<c12384a5>] ? sub_preempt_count+0x85/0xc0
<4>[ 7960.381322]  [<c1265833>] ? worker_thread+0x123/0x2c0
<4>[ 7960.381333]  [<c186e445>] ? schedule+0x545/0x9e0
<4>[ 7960.381346]  [<c128ac30>] ? suspend+0x0/0x160
<4>[ 7960.381357]  [<c12690d0>] ? autoremove_wake_function+0x0/0x50
<4>[ 7960.381369]  [<c1265710>] ? worker_thread+0x0/0x2c0
<4>[ 7960.381381]  [<c1268c34>] ? kthread+0x74/0x80
<4>[ 7960.381393]  [<c1268bc0>] ? kthread+0x0/0x80
<4>[ 7960.381405]  [<c120357a>] ? kernel_thread_helper+0x6/0x1


So my question, is it possible that the complete() called in interrupt context
can be missed
During S3?

-Illyas

------=_NextPart_000_0027_01CCDC6B.FF930BA0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIYaDCCAyAw
ggKJoAMCAQICBDXe9M8wDQYJKoZIhvcNAQEFBQAwTjELMAkGA1UEBhMCVVMxEDAOBgNVBAoTB0Vx
dWlmYXgxLTArBgNVBAsTJEVxdWlmYXggU2VjdXJlIENlcnRpZmljYXRlIEF1dGhvcml0eTAeFw05
ODA4MjIxNjQxNTFaFw0xODA4MjIxNjQxNTFaME4xCzAJBgNVBAYTAlVTMRAwDgYDVQQKEwdFcXVp
ZmF4MS0wKwYDVQQLEyRFcXVpZmF4IFNlY3VyZSBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkwgZ8wDQYJ
KoZIhvcNAQEBBQADgY0AMIGJAoGBAMFdsVhnCGLuoJotHwhtkRRomAoe/toEbxOEYiHD0XzOnwXg
uAHwTjTs4oqVBGSs8WtTXwWzy2eAv0ICjv7dAQns4QAUT/z78AzdQ7pbK+EfgHCZFVeTFvEPl2q3
wmgjHMxNWTCsUR47ryvW7mNFe8XZX1DS41APOojnvxT94Me5AgMBAAGjggEJMIIBBTBwBgNVHR8E
aTBnMGWgY6BhpF8wXTELMAkGA1UEBhMCVVMxEDAOBgNVBAoTB0VxdWlmYXgxLTArBgNVBAsTJEVx
dWlmYXggU2VjdXJlIENlcnRpZmljYXRlIEF1dGhvcml0eTENMAsGA1UEAxMEQ1JMMTAaBgNVHRAE
EzARgQ8yMDE4MDgyMjE2NDE1MVowCwYDVR0PBAQDAgEGMB8GA1UdIwQYMBaAFEjmaPkr0rKV10fY
IyAQTzOYkJ/UMB0GA1UdDgQWBBRI5mj5K9KylddH2CMgEE8zmJCf1DAMBgNVHRMEBTADAQH/MBoG
CSqGSIb2fQdBAAQNMAsbBVYzLjBjAwIGwDANBgkqhkiG9w0BAQUFAAOBgQBYzinq/Pfetc4CuRe1
hdG54+CVzCUxDQCmkm5/tpJjnlCV0Zpv5BHeY4VumO6o/1rI01WyZnFX3sAh6z0qpyNJAQSGQnv8
7n+iFlK1Z2fTQNs7JliyKHc9rhR3Ydb6KmYnoA36p3Nc6nDxlCFlRF/6/O8paKmih3nvee9PrAd3
ODCCAz0wggKmoAMCAQICAwWw/zANBgkqhkiG9w0BAQUFADBOMQswCQYDVQQGEwJVUzEQMA4GA1UE
ChMHRXF1aWZheDEtMCsGA1UECxMkRXF1aWZheCBTZWN1cmUgQ2VydGlmaWNhdGUgQXV0aG9yaXR5
MB4XDTA2MDIxNjE4MDEzMFoXDTE2MDIxOTE4MDEzMFowUjELMAkGA1UEBhMCVVMxGjAYBgNVBAoT
EUludGVsIENvcnBvcmF0aW9uMScwJQYDVQQDEx5JbnRlbCBFeHRlcm5hbCBCYXNpYyBQb2xpY3kg
Q0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDBpd/XOb9QVqEZ8mQ1042TdOIq3ATD
IsV2xDyt30yLyMR5Wjtus0bn3B+he89BiNO/LP6+rFzEwlD55PlX+HLGIKeNNG97dqyc30FElEUj
ZzTZFq2N4e3kVJ/XAEEgANzV8v9qp7qWwxugPgfc3z9BkYot+CifozexHLb/hEZj+yISCU61kRZv
uSQ0E11yYL4dRgcglJeaHo3oX57rvIckaLsYV5/1Aj+R8DM1Ppk965XQAKsHfnyT7C4S50T4lVn4
lz36wOdNZn/zegG1zp41lnoTFfT4KuKVJH5x7YD1p6KbgJCKLovnujGuohquBNfdXKpZkvz6pGv+
iC1HawJdAgMBAAGjgaAwgZ0wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBQaxgxKxEdvqNutK/D0
Vgaj7TdUDDA6BgNVHR8EMzAxMC+gLaArhilodHRwOi8vY3JsLmdlb3RydXN0LmNvbS9jcmxzL3Nl
Y3VyZWNhLmNybDAfBgNVHSMEGDAWgBRI5mj5K9KylddH2CMgEE8zmJCf1DAPBgNVHRMBAf8EBTAD
AQH/MA0GCSqGSIb3DQEBBQUAA4GBABMQOK2kVKVIlUWwLTdywJ+e2O+PC/uQltK2F3lRyrPfBn69
tOkIP4SgDJOfsxyobIrPLe75kBLw+Dom13OBDp/EMZJZ1CglQfVV8co9mT3aZMjSGGQiMgkJLR3j
Mfr900fXZKj5XeqCJ+JP0mEhJGEdVCY+FFlksJjV86fDrq1QMIIFijCCBHKgAwIBAgIKYSCKYgAA
AAAACDANBgkqhkiG9w0BAQUFADBSMQswCQYDVQQGEwJVUzEaMBgGA1UEChMRSW50ZWwgQ29ycG9y
YXRpb24xJzAlBgNVBAMTHkludGVsIEV4dGVybmFsIEJhc2ljIFBvbGljeSBDQTAeFw0wOTA1MTUx
OTI3MjZaFw0xNTA1MTUxOTM3MjZaMFYxCzAJBgNVBAYTAlVTMRowGAYDVQQKExFJbnRlbCBDb3Jw
b3JhdGlvbjErMCkGA1UEAxMiSW50ZWwgRXh0ZXJuYWwgQmFzaWMgSXNzdWluZyBDQSAzQjCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKQEM1Wn9TU9vc9C+/Tc7KB+eiYElmrcEWE32WUd
HvWG+IcQHVQsikTmMyKKojNLw2B5s6Iekc8ivDo/wCfjZzX9JyftMnc+AArc0la87Olybzm8K9jX
EfTBvTnUSFSiI9ZYefITdiUgqlAFuljFZEHYKYtLuhrRacpmQfP4mV63NKdc2bT804HRf6YptZFa
4k6YN94zlrGNrBuQQ74WFzz/jLBusbUpEkro6Mu/ZYFOFWQrV9lBhF9Ruk8yN+3N6n9fUo/qBigi
F2kEn9xVh1ykl7SCGL2jBUkXx4qgV27a6Si8lRRdgrHGtN/HWnSWlLXTH5l575H4Lq++77OFv38C
AwEAAaOCAlwwggJYMA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFA7GKvdZsggQkCVvw939imYx
MCvFMAsGA1UdDwQEAwIBhjASBgkrBgEEAYI3FQEEBQIDAQABMCMGCSsGAQQBgjcVAgQWBBQ5oFY2
ekKQ/5Ktim+VdMeSWb4QWTAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTAfBgNVHSMEGDAWgBQa
xgxKxEdvqNutK/D0Vgaj7TdUDDCBvQYDVR0fBIG1MIGyMIGvoIGsoIGphk5odHRwOi8vd3d3Lmlu
dGVsLmNvbS9yZXBvc2l0b3J5L0NSTC9JbnRlbCUyMEV4dGVybmFsJTIwQmFzaWMlMjBQb2xpY3kl
MjBDQS5jcmyGV2h0dHA6Ly9jZXJ0aWZpY2F0ZXMuaW50ZWwuY29tL3JlcG9zaXRvcnkvQ1JML0lu
dGVsJTIwRXh0ZXJuYWwlMjBCYXNpYyUyMFBvbGljeSUyMENBLmNybDCB4wYIKwYBBQUHAQEEgdYw
gdMwYwYIKwYBBQUHMAKGV2h0dHA6Ly93d3cuaW50ZWwuY29tL3JlcG9zaXRvcnkvY2VydGlmaWNh
dGVzL0ludGVsJTIwRXh0ZXJuYWwlMjBCYXNpYyUyMFBvbGljeSUyMENBLmNydDBsBggrBgEFBQcw
AoZgaHR0cDovL2NlcnRpZmljYXRlcy5pbnRlbC5jb20vcmVwb3NpdG9yeS9jZXJ0aWZpY2F0ZXMv
SW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwUG9saWN5JTIwQ0EuY3J0MA0GCSqGSIb3DQEBBQUA
A4IBAQCxtQEHchVQhXyjEqtMVUMe6gkmPsIczHxSeqNbo9dsD+6xbT65JT+oYgpIAtfEsYXeUJu1
cChqpb22U5bMAz7eaQcW5bzefufWvA6lg2048B8oczBj/q+5P5NpYrUO8jOmN4jTjfJq3ElZ7yFW
py7rB3Vm/aN6ATYqWfMbS/xfh+JCxmH3droUmMJI0/aZJHsLtjbjFnNsHDNrJZX1vxlM78Lb1hjs
kTENPmhbVbfTj5i/ZGnhv4tmI8QZPCNtcegXJrfhRl2D9bWpdTOPrWiLDUqzy1Z6KL7TcOS/PCl8
RHCJXkPau/thTQCpIoDa2+c+3XA++gRTfAQ4svTO260NMIIGEzCCBPugAwIBAgIKFWACkwABAACH
wDANBgkqhkiG9w0BAQUFADBWMQswCQYDVQQGEwJVUzEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRp
b24xKzApBgNVBAMTIkludGVsIEV4dGVybmFsIEJhc2ljIElzc3VpbmcgQ0EgM0IwHhcNMTIwMTI2
MDY0MzEzWhcNMTUwMTEwMDY0MzEzWjBDMRgwFgYDVQQDEw9NYW5zb29yLCBJbGx5YXMxJzAlBgkq
hkiG9w0BCQEWGGlsbHlhcy5tYW5zb29yQGludGVsLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAOLKk+CT5hEwsQdwos/OqCkUifVuyWoby0kGe6UsisRLKMgdFJQRcbEZc854jPbe
8YISCDRl1hTBq+vT9ZRwm7sStOI93WJF6Ob66+A12bab8qgSw6HLjYErSnXwLtrj2y+zScrNaSRJ
Xr+m59nIxba+8NvudUJ1FX0WQVmQFnCuJylzko8GPhFQBDmRQnwRCX0VJM/lJQOZOqQr5MoARNYN
V1A5mvEqMS2Hfe8qrfkaO2alLgC7tg36U78OhOwfIDW9MWkqtoVY7PT+WVfZ9UbUUwI+eWzPwPmz
KbouW0RA7PBva7AYQnFnbvFqBsDfiNhbccADYudqsvnyek1SaQECAwEAAaOCAvQwggLwMAsGA1Ud
DwQEAwIHgDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiGw4x1hJnlUYP9gSiFjp9TgpHACWeB
3r05lfBDAgFkAgEIMB0GA1UdDgQWBBSSPPfdaC41Y8K1RPfESldXb64J4jAfBgNVHSMEGDAWgBQO
xir3WbIIEJAlb8Pd/YpmMTArxTCBzwYDVR0fBIHHMIHEMIHBoIG+oIG7hldodHRwOi8vd3d3Lmlu
dGVsLmNvbS9yZXBvc2l0b3J5L0NSTC9JbnRlbCUyMEV4dGVybmFsJTIwQmFzaWMlMjBJc3N1aW5n
JTIwQ0ElMjAzQigxKS5jcmyGYGh0dHA6Ly9jZXJ0aWZpY2F0ZXMuaW50ZWwuY29tL3JlcG9zaXRv
cnkvQ1JML0ludGVsJTIwRXh0ZXJuYWwlMjBCYXNpYyUyMElzc3VpbmclMjBDQSUyMDNCKDEpLmNy
bDCB9QYIKwYBBQUHAQEEgegwgeUwbAYIKwYBBQUHMAKGYGh0dHA6Ly93d3cuaW50ZWwuY29tL3Jl
cG9zaXRvcnkvY2VydGlmaWNhdGVzL0ludGVsJTIwRXh0ZXJuYWwlMjBCYXNpYyUyMElzc3Vpbmcl
MjBDQSUyMDNCKDEpLmNydDB1BggrBgEFBQcwAoZpaHR0cDovL2NlcnRpZmljYXRlcy5pbnRlbC5j
b20vcmVwb3NpdG9yeS9jZXJ0aWZpY2F0ZXMvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNz
dWluZyUyMENBJTIwM0IoMSkuY3J0MB8GA1UdJQQYMBYGCCsGAQUFBwMEBgorBgEEAYI3CgMMMCkG
CSsGAQQBgjcVCgQcMBowCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDDDBNBgNVHREERjBEoCgGCisG
AQQBgjcUAgOgGgwYaWxseWFzLm1hbnNvb3JAaW50ZWwuY29tgRhpbGx5YXMubWFuc29vckBpbnRl
bC5jb20wDQYJKoZIhvcNAQEFBQADggEBAFPpw1PlHMUQjyxONBjYnTRfozVus7KykXMaZQWTVGIc
oeF9H7V0tzl0wB3z1bD21t91rWsDoAZOB6kxjz7i01a6mR8OHv341m8818/kgC8LQglZnDWDHdxY
Hp3vDu+o6QwH7CVVSf6ymi/6aihQCWLZRctSEvXvXx4K/SGkFGNMlKm5RDV+htQ5KDfk9T9LVr3W
lW69t3Wf3Tsm5qy1v5QczGFwZqCca/67ghrwP8dYhp9Ir9bqocJcdZYjWmZEDPz/3fj6PXxxdh2F
vOCy32HDBE6L796BVOiI9d4bbxuTcoUmL53sF6r7lNpImt4ASlnnkQRcR1rrWPJXC6H7lEwwggZa
MIIFQqADAgECAgoVZHP3AAEAAIfBMA0GCSqGSIb3DQEBBQUAMFYxCzAJBgNVBAYTAlVTMRowGAYD
VQQKExFJbnRlbCBDb3Jwb3JhdGlvbjErMCkGA1UEAxMiSW50ZWwgRXh0ZXJuYWwgQmFzaWMgSXNz
dWluZyBDQSAzQjAeFw0xMjAxMjYwNjQ4MDVaFw0xNTAxMTAwNjQ4MDVaMEMxGDAWBgNVBAMTD01h
bnNvb3IsIElsbHlhczEnMCUGCSqGSIb3DQEJARYYaWxseWFzLm1hbnNvb3JAaW50ZWwuY29tMIIB
IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAgvl4tjFKG7qkJ5HgPVOntL0NZCDa1tfKb8hT
zbHPlqLaiRAZJd/QjJcvMVMNhnk2BqpUk7564Xi4WK8Xb/qGBScfGmNRgD6rusizYoB6WrN1Fg9A
LhlZQygA24tsm5MspWOafPCrgDY8OLgC+48GdWzWYxtEB+f8qM8n3s1JQ/fRQqRsvei4vcyNce/S
wlIlYJH0EyeJuR3sMpShZdexnfnArSkttheYo8tnL6TT/SqXZ4C51AXiV4cU6z7DNPTx0Ae24UnD
eAtvsoKiqds//Wk9gk4qoaF5IhXevz2PcG3zqGgvt0pTDj79Umb4mza8EmtUc2UtliBnhXo+qVv1
3QIDAQABo4IDOzCCAzcwCwYDVR0PBAQDAgQwMD0GCSsGAQQBgjcVBwQwMC4GJisGAQQBgjcVCIbD
jHWEmeVRg/2BKIWOn1OCkcAJZ4S52UGHhP9OAgFkAgEMMEQGCSqGSIb3DQEJDwQ3MDUwDgYIKoZI
hvcNAwICAgCAMA4GCCqGSIb3DQMEAgIAgDAHBgUrDgMCBzAKBggqhkiG9w0DBzAdBgNVHQ4EFgQU
UkdcLiBuK8C6TP9mVRypaDJDFlUwHwYDVR0jBBgwFoAUDsYq91myCBCQJW/D3f2KZjEwK8Uwgc8G
A1UdHwSBxzCBxDCBwaCBvqCBu4ZXaHR0cDovL3d3dy5pbnRlbC5jb20vcmVwb3NpdG9yeS9DUkwv
SW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENBJTIwM0IoMSkuY3JshmBodHRw
Oi8vY2VydGlmaWNhdGVzLmludGVsLmNvbS9yZXBvc2l0b3J5L0NSTC9JbnRlbCUyMEV4dGVybmFs
JTIwQmFzaWMlMjBJc3N1aW5nJTIwQ0ElMjAzQigxKS5jcmwwgfUGCCsGAQUFBwEBBIHoMIHlMGwG
CCsGAQUFBzAChmBodHRwOi8vd3d3LmludGVsLmNvbS9yZXBvc2l0b3J5L2NlcnRpZmljYXRlcy9J
bnRlbCUyMEV4dGVybmFsJTIwQmFzaWMlMjBJc3N1aW5nJTIwQ0ElMjAzQigxKS5jcnQwdQYIKwYB
BQUHMAKGaWh0dHA6Ly9jZXJ0aWZpY2F0ZXMuaW50ZWwuY29tL3JlcG9zaXRvcnkvY2VydGlmaWNh
dGVzL0ludGVsJTIwRXh0ZXJuYWwlMjBCYXNpYyUyMElzc3VpbmclMjBDQSUyMDNCKDEpLmNydDAf
BgNVHSUEGDAWBggrBgEFBQcDBAYKKwYBBAGCNwoDBDApBgkrBgEEAYI3FQoEHDAaMAoGCCsGAQUF
BwMEMAwGCisGAQQBgjcKAwQwTQYDVR0RBEYwRKAoBgorBgEEAYI3FAIDoBoMGGlsbHlhcy5tYW5z
b29yQGludGVsLmNvbYEYaWxseWFzLm1hbnNvb3JAaW50ZWwuY29tMA0GCSqGSIb3DQEBBQUAA4IB
AQBEffGupAfAE+Y5L+hlXS1UW0TEDOnQBq3uypJmipQTm+b6rDUeaME1HSPqk0N640yUFZYO9wr4
3QeVWksRsIz7jxB7u7byd2sou8Z9Gx57o79FC3UCvmTWn0+Au2+klUdqi5ZyawlxPkwJyG0/oaKQ
CABK3zUgLxhIv0d007LHgoyv4+jSPETqYlofCffG1pxEquL50D08k+W2x1GEkxqgASMqneT6FKJz
nYijxwnZz4mnHAnFc8KFJnmzsb3GkrcKAtBXYbux0Jbp/ZVdgyKzrensNsUMG2p6lPLSXcs5Pmlt
95t1h2XcwOThPPvE6lumj8IXDJwEbyrbUeqCli3IMYIDhjCCA4ICAQEwZDBWMQswCQYDVQQGEwJV
UzEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIkludGVsIEV4dGVybmFsIEJh
c2ljIElzc3VpbmcgQ0EgM0ICChVgApMAAQAAh8AwCQYFKw4DAhoFAKCCAfcwGAYJKoZIhvcNAQkD
MQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTIwMTI2MTUxOTI5WjAjBgkqhkiG9w0BCQQx
FgQUKkqVzNK+gJyye9B8QzV0kkqqsoYwcwYJKwYBBAGCNxAEMWYwZDBWMQswCQYDVQQGEwJVUzEa
MBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIkludGVsIEV4dGVybmFsIEJhc2lj
IElzc3VpbmcgQ0EgM0ICChVkc/cAAQAAh8EwdQYLKoZIhvcNAQkQAgsxZqBkMFYxCzAJBgNVBAYT
AlVTMRowGAYDVQQKExFJbnRlbCBDb3Jwb3JhdGlvbjErMCkGA1UEAxMiSW50ZWwgRXh0ZXJuYWwg
QmFzaWMgSXNzdWluZyBDQSAzQgIKFWRz9wABAACHwTCBqwYJKoZIhvcNAQkPMYGdMIGaMAsGCWCG
SAFlAwQBKjALBglghkgBZQMEARYwCgYIKoZIhvcNAwcwCwYJYIZIAWUDBAECMA4GCCqGSIb3DQMC
AgIAgDAHBgUrDgMCBzANBggqhkiG9w0DAgIBQDANBggqhkiG9w0DAgIBKDAHBgUrDgMCGjALBglg
hkgBZQMEAgMwCwYJYIZIAWUDBAICMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB6yOPa
/fIiusPlwO0nI5nm9qEomgRz3t/0vFnFCAdT/lt9MHhg29a4IEyczDXSp9uI3mOtrPHu7jqJB7Ei
fxmnR6MEv0bG6rrB7EKWPd7lcyL62CllkKY3ng3tkVNXC1WwsGEhLrczuD4Q3/ywIQunb+gcpcO3
jA/75y737wTq6m3ozrQ6dR4DKGsjZfyKmfzmXf/7U6roYmNFOJFgRQJgP4nvBE72e/yk1RvfLPGz
O8VrXYYCwYJjMclUjcRtOVAOKDkoiQLUGi4F8I4D0AzgBeuZrPNInuMZSwkopDXUS5FIpM09G+sX
KcJXcmMomPtSx+CqZfzM3eeXVdIobsj0AAAAAAAA

------=_NextPart_000_0027_01CCDC6B.FF930BA0--

--===============3268851523970860731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3268851523970860731==--
