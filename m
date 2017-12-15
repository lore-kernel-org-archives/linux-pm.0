From: Thomas Ilsche <thomas.ilsche@tu-dresden.de>
Subject: Re: [PATCH] cpuidle: Allow menu governor to enter deeper sleep states
 after some time
Date: Fri, 15 Dec 2017 11:44:02 +0100
Message-ID: <25c78d66-9c2a-012c-6574-a687519d4820@tu-dresden.de>
References: <a181bf42-9462-476c-6dcd-39fc7151957f@tu-dresden.de>
 <000101d34938$da740870$8f5c1950$@net> <000801d34a78$cdd27890$697769b0$@net>
 <002c01d35d0f$8b0416f0$a10c44d0$@net> <000a01d3654a$c4996990$4dcc3cb0$@net>
 <17b7bd4f-6b4d-2561-8895-f1dd32f9a171@tu-dresden.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms050300000309030600090701"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout5.zih.tu-dresden.de ([141.30.67.74]:56245 "EHLO
        mailout5.zih.tu-dresden.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755763AbdLOKoF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Dec 2017 05:44:05 -0500
In-Reply-To: <17b7bd4f-6b4d-2561-8895-f1dd32f9a171@tu-dresden.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>, 'Len Brown' <lenb@kernel.org>
Cc: 'Yu Chen' <yu.c.chen@intel.com>, =?UTF-8?Q?'Marcus_H=c3=a4hnel'?= <mhaehnel@os.inf.tu-dresden.de>, 'Daniel Hackenberg' <daniel.hackenberg@tu-dresden.de>, =?UTF-8?Q?'Robert_Sch=c3=b6ne'?= <robert.schoene@tu-dresden.de>, mario.bielert@tu-dresden.de, "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, 'Alex Shi' <alex.shi@linaro.org>, 'Ingo Molnar' <mingo@kernel.org>, 'Rik van Riel' <riel@redhat.com>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Nicholas Piggin' <npiggin@gmail.com>, linux-pm@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms050300000309030600090701
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Len, Doug,

we just saw very bad Powernightmares on a freshly installed dual socket 3=
6 core
Skylake system. There is a particular steep increase in AC system power f=
rom
69 W to 120 W just from having a single core not in the deepest state.
Together with high occurrence and persistence, this raises average idle p=
ower
from 69 W to 92 W. You can see a typical example power chart at [1] measu=
red
externally right after the installation. This is a default installation o=
f
Ubuntu 16.04, but upgrading to a 4.15.0-rc3 kernel provides no help.

This issue is probably wasting a couple Megawatts globally, and it's gett=
ing
worse with newer Intel processor generations. I like to reinforce the off=
er
to help develop and test a patch, but the points below need to be address=
ed
by an experienced kernel developer / maintainer.

We acknowledge your suggestion to keep the scheduling ticks running inste=
ad
of using an additional fallback timer. Still, we need a solution with
manageable code changes without tightly coupling different software layer=
s.
Unfortunately, the tick-timer is disabled early in the outer idle-loop in=

do_idle(), but the C-state decision is taken in the governor.

In your opinion, what is the best solution?
(a) re-enable the tick-timer? (not a very clean solution)
(b) moving the tick-timer disabling? (could be very intrusive in terms of=
 LOC,
we have no overview on which assumptions would break if we do this)
(c) use the fallback timer (not elegant, since there are already ticks)

Regarding the C0/poll_idle problem, what is suitable as abort criterion:
(a) interrupt counts
(b) tick_nohz_get_sleep_length
(c) tick_sched->idle_expires

Best,
Thomas

[1] https://wwwpub.zih.tu-dresden.de/~tilsche/powernightmares_skl.png


--------------ms050300000309030600090701
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
EGIwggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYT
AkRFMSswKQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYD
VQQLDBZULVN5c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFs
Um9vdCBDbGFzcyAyMB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNV
BAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVu
IEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERG
Ti1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMtg1/9moUHN0vqHl4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZs
FVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8FXRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0p
eQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+BaL2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0
WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qLNupOkSk9s1FcragMvp0049ENF4N1
xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz9AkH4wKGMUZrAcUQDBHHWekC
AwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUk+PYMiba1fFKpZFK4OpL
4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYDVR0TAQH/BAgwBgEB
/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGCLB4wCAYGZ4EM
AQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUvcmwvVGVs
ZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYBBQUH
MAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5j
ZXIwDQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4
eTizDnS6dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/
MOaZ/SLick0+hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3S
PXez7vTXTf/D6OWST1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc2
2CzeIs2LgtjZeOJVEqM7h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bP
ZYoaorVyGTkwggWWMIIEfqADAgECAgwcbjQkPzrYLBvMkTUwDQYJKoZIhvcNAQELBQAwgZUx
CzAJBgNVBAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1
dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNV
BAMTJERGTi1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjAeFw0xNjEyMTIxNDM5
MTZaFw0zMTAyMjIyMzU5NTlaMHMxCzAJBgNVBAYTAkRFMRAwDgYDVQQIDAdTYWNoc2VuMRAw
DgYDVQQHDAdEcmVzZGVuMSgwJgYDVQQKDB9UZWNobmlzY2hlIFVuaXZlcnNpdGFldCBEcmVz
ZGVuMRYwFAYDVQQDDA1UVSBEcmVzZGVuIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEA5+CCc42Y1+0J5tpASWPSYx/0Pxqj97P1DdzCbTh3XwppRsAMtqNwS8sTxgHMmbNA
ol18t3EqIkTH/iSXEhd5cf6OSyHumVbgvZTvjMh/c7R3VGZiwqimlhk4/UJV8nVPvrL24Guk
D17Rsv+iLe5Mse7HIMJ7e9ciArdCBV5W6kk/5O24/ZhttIEs/2I3i8MTlGoBaesNgkUy/cRa
A0hw1BBTrDbfK1vhbxV/CWb+czy0F0M5W31LToGrXuwoFrhggn5X/LrFXvCb8/9w+jSk8WzG
vJw6MlPGXHwuTfjf7oei/S0j7iHq5fyIH3lEs58M4kwxlLViv2rc3KJkTX5xmQIDAQABo4IC
BTCCAgEwEgYDVR0TAQH/BAgwBgEB/wIBATAOBgNVHQ8BAf8EBAMCAQYwKQYDVR0gBCIwIDAN
BgsrBgEEAYGtIYIsHjAPBg0rBgEEAYGtIYIsAQEEMB0GA1UdDgQWBBRS/r63JMIbCh1GUo5E
JCr0SEA9ATAfBgNVHSMEGDAWgBST49gyJtrV8UqlkUrg6kviogzP4TCBjwYDVR0fBIGHMIGE
MECgPqA8hjpodHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9j
cmwvY2FjcmwuY3JsMECgPqA8hjpodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2dsb2JhbC1yb290
LWcyLWNhL3B1Yi9jcmwvY2FjcmwuY3JsMIHdBggrBgEFBQcBAQSB0DCBzTAzBggrBgEFBQcw
AYYnaHR0cDovL29jc3AucGNhLmRmbi5kZS9PQ1NQLVNlcnZlci9PQ1NQMEoGCCsGAQUFBzAC
hj5odHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jYWNlcnQv
Y2FjZXJ0LmNydDBKBggrBgEFBQcwAoY+aHR0cDovL2NkcDIucGNhLmRmbi5kZS9nbG9iYWwt
cm9vdC1nMi1jYS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBAEzY
RPywOGl/wZ/Mdz2gLDMbO39f7+iQcrVPRy/lbjjLt+0bouai8xTj1I9N+W4ZOhGww55gXMNO
nBiKouODdNcazTxW6+glA4+5K9bxkAKu9kl9J2ezpcMw1PNTFFcS1yG+thGQTtuy+3S3fI6V
Ifxi+RawFri9sC7010qS3RwOShmhsLk3iEjlDQ180zkBzsdevWHt1svALpqsc+7DcHuP+MgY
vkow/1uyHp3vyeTE9K7hdxcfXwRQ9IkeCo9xLJUeykuosqrTOQNe4Yw4hPhrJfRtoyH92SFq
deZenVeU6+rkquev61X3fPi+/ySpUOGyWPdggN65bQ81E8nLFYUwggWuMIIElqADAgECAgwc
vTmIr0re9lfFR20wDQYJKoZIhvcNAQELBQAwczELMAkGA1UEBhMCREUxEDAOBgNVBAgMB1Nh
Y2hzZW4xEDAOBgNVBAcMB0RyZXNkZW4xKDAmBgNVBAoMH1RlY2huaXNjaGUgVW5pdmVyc2l0
YWV0IERyZXNkZW4xFjAUBgNVBAMMDVRVIERyZXNkZW4gQ0EwHhcNMTcwMjEwMTMxMTIwWhcN
MjAwMjEwMTMxMTIwWjBdMQswCQYDVQQGEwJERTEoMCYGA1UECgwfVGVjaG5pc2NoZSBVbml2
ZXJzaXRhZXQgRHJlc2RlbjEMMAoGA1UECwwDWklIMRYwFAYDVQQDDA1UaG9tYXMgSWxzY2hl
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAw5dKRIicycpBdQWviYlPQxn61uc0
dMnov1GqB3JoJpRyWICwOBn0EWcbKatI1VS6PbAbmCaXjujAZnhIppGj8NQdU15E4HaC0TDp
ucodW2vxb75srHBQ5WBwo3SDHF1gT1l6mAzr1fVddmLi2yV0kK6gaervW4gAh46l5Es6jjnp
ugT1eatFuUy2M/H/MXEeW/lWgOG3POatGOmOR/OC3c321z4OynPk2/LIEnPfrSvpCQZDrKsF
9miwvoXbkYWUAN/qhDEkyYPh/YPQ9YMg5Bgs4xz+EqEECOi8v0DWfxwgQ5zyfRW5aBj5bw0b
PLOydh4m2ufwM+Q7KQfgF04eZwIDAQABo4ICVjCCAlIwCQYDVR0TBAIwADAOBgNVHQ8BAf8E
BAMCBeAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMB0GA1UdDgQWBBQ5omhFY59I
NNeLxf+a6i2MFhszdjAfBgNVHSMEGDAWgBRS/r63JMIbCh1GUo5EJCr0SEA9ATAmBgNVHREE
HzAdgRt0aG9tYXMuaWxzY2hlQHR1LWRyZXNkZW4uZGUwgY0GA1UdHwSBhTCBgjA/oD2gO4Y5
aHR0cDovL2NkcDEucGNhLmRmbi5kZS90dS1kcmVzZGVuLWcyLWNhL3B1Yi9jcmwvY2Fjcmwu
Y3JsMD+gPaA7hjlodHRwOi8vY2RwMi5wY2EuZGZuLmRlL3R1LWRyZXNkZW4tZzItY2EvcHVi
L2NybC9jYWNybC5jcmwwgdsGCCsGAQUFBwEBBIHOMIHLMDMGCCsGAQUFBzABhidodHRwOi8v
b2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVyL09DU1AwSQYIKwYBBQUHMAKGPWh0dHA6Ly9j
ZHAxLnBjYS5kZm4uZGUvdHUtZHJlc2Rlbi1nMi1jYS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQw
SQYIKwYBBQUHMAKGPWh0dHA6Ly9jZHAyLnBjYS5kZm4uZGUvdHUtZHJlc2Rlbi1nMi1jYS9w
dWIvY2FjZXJ0L2NhY2VydC5jcnQwQAYDVR0gBDkwNzARBg8rBgEEAYGtIYIsAQEEAwUwEQYP
KwYBBAGBrSGCLAIBBAMBMA8GDSsGAQQBga0hgiwBAQQwDQYJKoZIhvcNAQELBQADggEBACfM
PajpRlVEBvEeDqkek2aRlU1xLCR1ulK4Z8WlMN+cPnjONaEfYp3oBwqiUNKjNa4VpniQLvXM
xDWgncPOavlajnIH5urkss7iDV9ImaZEyW6sU9ZemBXGN3PP5xI1xX4dKA32N/8J57D+0Im5
I2aa6wLpeFa24qr2b5tXke77ZQwAOxp0CryiVkVP/5rp4C8D43I7x/uRhWbmxzaj+/bMwyZ0
gTsJ/k9KQaR+8oqdDn/X/PI1e7GWNykhhjG+QP1hwj2HqRRAYlTN4S3OAedvNPxtBK+28TGu
bAfD2IQZdvYAqSQT6qt2W1KkUMN38bRKdcICdqm8+fUMe7yKuvQxggO6MIIDtgIBATCBgzBz
MQswCQYDVQQGEwJERTEQMA4GA1UECAwHU2FjaHNlbjEQMA4GA1UEBwwHRHJlc2RlbjEoMCYG
A1UECgwfVGVjaG5pc2NoZSBVbml2ZXJzaXRhZXQgRHJlc2RlbjEWMBQGA1UEAwwNVFUgRHJl
c2RlbiBDQQIMHL05iK9K3vZXxUdtMA0GCWCGSAFlAwQCAQUAoIICBzAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNzEyMTUxMDQ0MDJaMC8GCSqGSIb3DQEJ
BDEiBCAuGOTltuRFdOZ9Ax/Lp4eMyn4CNa0YsTAy2c7TZR2xWTBsBgkqhkiG9w0BCQ8xXzBd
MAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGUBgkrBgEEAYI3EAQx
gYYwgYMwczELMAkGA1UEBhMCREUxEDAOBgNVBAgMB1NhY2hzZW4xEDAOBgNVBAcMB0RyZXNk
ZW4xKDAmBgNVBAoMH1RlY2huaXNjaGUgVW5pdmVyc2l0YWV0IERyZXNkZW4xFjAUBgNVBAMM
DVRVIERyZXNkZW4gQ0ECDBy9OYivSt72V8VHbTCBlgYLKoZIhvcNAQkQAgsxgYaggYMwczEL
MAkGA1UEBhMCREUxEDAOBgNVBAgMB1NhY2hzZW4xEDAOBgNVBAcMB0RyZXNkZW4xKDAmBgNV
BAoMH1RlY2huaXNjaGUgVW5pdmVyc2l0YWV0IERyZXNkZW4xFjAUBgNVBAMMDVRVIERyZXNk
ZW4gQ0ECDBy9OYivSt72V8VHbTANBgkqhkiG9w0BAQEFAASCAQCICoCAH0xcFeI4irDccIws
lbfxeAPtVerrnbeWmA56lR8OSGMBgCCKJ+6enDT4Gia8WyAMNjgBWCmqNEmf05iVRLX7YOFV
uZIiqfcXMdcgIqtiBGlXtbBPKyNmfD17y2ie1vuk7lwqlE2biDAtek24pvgehBqPaGNA6ATb
Z3o34GviBod1WudFrZI0iH4ClWbElFrl1LIIiaEWf0wUVUqIlUfLz7chWcmFe5X4nlI6Auv9
Q7i2BvqoPruLGqeR4gIONB0yM26uPPIOyWO/Rir9rMNPdMxvOt0DQRoWcaFqwLQnDmzg6HgA
qLN4DU2CDa0psKS4Vp9JIxFtbPw3cbCoAAAAAAAA
--------------ms050300000309030600090701--
