From: Thomas Ilsche <thomas.ilsche@tu-dresden.de>
Subject: Re: [PATCH] cpuidle: Allow menu governor to enter deeper sleep states
 after some time
Date: Fri, 20 Oct 2017 19:13:52 +0200
Message-ID: <a179cc88-632e-0c01-77b1-b64f62634ff3@tu-dresden.de>
References: <a181bf42-9462-476c-6dcd-39fc7151957f@tu-dresden.de>
 <000101d34938$da740870$8f5c1950$@net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms010402090207090508090909"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout5.zih.tu-dresden.de ([141.30.67.74]:44194 "EHLO
        mailout5.zih.tu-dresden.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752589AbdJTRNz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Oct 2017 13:13:55 -0400
In-Reply-To: <000101d34938$da740870$8f5c1950$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: =?UTF-8?Q?'Marcus_H=c3=a4hnel'?= <mhaehnel@os.inf.tu-dresden.de>, 'Daniel Hackenberg' <daniel.hackenberg@tu-dresden.de>, =?UTF-8?Q?'Robert_Sch=c3=b6ne'?= <robert.schoene@tu-dresden.de>, mario.bielert@tu-dresden.de, "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, 'Alex Shi' <alex.shi@linaro.org>, 'Ingo Molnar' <mingo@kernel.org>, 'Rik van Riel' <riel@redhat.com>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Nicholas Piggin' <npiggin@gmail.com>, linux-pm@vger.kernel.org, 'Len Brown' <lenb@kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms010402090207090508090909
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Doug,

thanks for reproducing, I'll come right to your issue

>> On several contemporary Intel systems, we have observed that the idle
>> power consumption is sometimes significantly too high, e.g. 105 W inst=
ead
>> of 74 W for several seconds.
>=20
> On my test system, I do not observe this magnitude of excessive idle en=
ergy.
> While I do observe occurrences of excessive time spent in idle state 0,=
 they
> do not add up to significant energy waste.
>=20
> [...]
>=20
> The problem I am struggling with is the patch makes no difference
> for my example use case of 100% load on one CPU, others idle.
> The wasted power is entirely from idle state 0, and idle state 0
> times remain about the same with or without the fallback timer.
> If I merely disable idle state 0, things are great. However,
> just disabling idle state 0 does not help when "powermightmares"
> are present.
>=20
> Example data (kernel 4.14-rc5 + this patch):
>=20
> Average package power with fallback timer disabled: ~27.2 watts
> Average package power with fallback timer enabled: ~28 watts
> Average package power with state 0 disabled, fallback timer disabled: ~=
23.9 watts
> Average package power with state 0 disabled, fallback timer enabled: ~2=
3.9 watts
 =20
That's strange, we haven't seen issues with state0 residency. The
menu idle governor explicitly tries to avoid polling, and on our
system C1 has a latency of 1. I'm not even sure if poll_idle can
run indefinitely similar to mwait.

Unfortunately, I don't have a complete picture of your issue.

1) What processor do you use and what are the following
/sys/devices/system/cpu/cpu*/cpuidle/state*/{name,latency,residency}

2) To get a better picture you can use perf via the following
events in addition to power and residency:

sched:sched_switch     -> which tasks are scheduled when.
power:cpu_idle (state) -> which state was used when going to sleep

Record a timeline with these events by using perf record -a -e
You could also use -C to select only the core that should be
idle but uses C0
You can analyse it via perf script (or perf timeline if you have a
scalable and fast SVG viewer, which I'm not sure exists)

If you see state0 selected before a long idle phase, it's what we
call a Powernightmare. The intervals of 8 previous idles can tell
what the heuristic tries.

Some things to consider to avoid other influences on power
- uniformity of the busy core's workload
- fixed userspace p-state
- pinned threads

If you can share a reproducible use-case I can also try with
our tool chain (recording toolchain is FOSS, visualizer is not)

>> @@ -190,6 +195,85 @@ static inline int performance_multiplier(unsigned=
 long nr_iowaiters, unsigned lo
>>   =20
>>    static DEFINE_PER_CPU(struct menu_device, menu_devices);
>>   =20
>> +static unsigned int fallback_timer_disregard_past =3D 1;
>> +static unsigned int diff_threshold_bits =3D 8;
>> +static unsigned int fallback_timer_enabled;
>=20
> Shouldn't fallback_timer_enabled be initialized?
> On my system it defaults to 0, or disabled, and due to another problem,=

> see further down, this patch wasn't working.

It was meant to be 0 for now, which is what static will be initialized to=
,
but I prefer explicit initialization.

>> +static unsigned int fallback_timer_interval_us =3D 10000;
>> +
>> +#define MENU_ATTR_RW(name, var, range_min, range_max, wfun) \
>> +	static ssize_t show_##name(struct device *dev, \
>> +				   struct device_attribute *attr, char *buf) \
>> +	{ \
>> +		return snprintf(buf, 12, "%i\n", var); \
>> +	} \
>> +	static ssize_t store_##name(struct device *dev, \
>> +				    struct device_attribute *attr, \
>> +				    const char *buf, size_t count) \
>> +	{ \
>> +		unsigned int tmp; \
>> +		int ret =3D kstrtouint(buf, 10, &tmp); \
>> +		if (ret !=3D 1) \
>=20
> Shouldn't this be:
>=20
>   +		if (ret !=3D 0) \
>=20
> (or maybe just " if (ret) \". I did (and therefore tested) the previous=
=2E
>=20
> ?
> Anyway, it doesn't work unless I make this change.

Yes. An unfortunate oversight during the last style-checker changes.
For sscanf the return code had to be 1. Sorry for the trouble.

Best,
Thomas

--=20
Dipl. Inf. Thomas Ilsche
Computer Scientist
Highly Adaptive Energy-Efficient Computing
CRC 912 HAEC: http://tu-dresden.de/sfb912
Technische Universit=C3=A4t Dresden
Center for Information Services and High Performance Computing (ZIH)
01062 Dresden, Germany

Phone: +49 351 463-42168
Fax: +49 351 463-37773
E-Mail: thomas.ilsche@tu-dresden.de


--------------ms010402090207090508090909
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
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNzEwMjAxNzEzNTJaMC8GCSqGSIb3DQEJ
BDEiBCCbT4rp9tQR3ab+rO93skSdbigS7gc9DcItuDajMmsGJTBsBgkqhkiG9w0BCQ8xXzBd
MAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGUBgkrBgEEAYI3EAQx
gYYwgYMwczELMAkGA1UEBhMCREUxEDAOBgNVBAgMB1NhY2hzZW4xEDAOBgNVBAcMB0RyZXNk
ZW4xKDAmBgNVBAoMH1RlY2huaXNjaGUgVW5pdmVyc2l0YWV0IERyZXNkZW4xFjAUBgNVBAMM
DVRVIERyZXNkZW4gQ0ECDBy9OYivSt72V8VHbTCBlgYLKoZIhvcNAQkQAgsxgYaggYMwczEL
MAkGA1UEBhMCREUxEDAOBgNVBAgMB1NhY2hzZW4xEDAOBgNVBAcMB0RyZXNkZW4xKDAmBgNV
BAoMH1RlY2huaXNjaGUgVW5pdmVyc2l0YWV0IERyZXNkZW4xFjAUBgNVBAMMDVRVIERyZXNk
ZW4gQ0ECDBy9OYivSt72V8VHbTANBgkqhkiG9w0BAQEFAASCAQA2SpdBUv6aAAEjSb9QbOyO
mT7jEQq1E2yYpxF9Z63aBN1/4frbTHhvZJlhsItzpAegHa5ohpxiSUJXmwbeaMhKCTV7EJ3p
7Rno9+G4aSk9xNkhuJ48zK+/KNzjpjzPoY1tXsJcHZmKfQt6jAVwWQsTfc2vYmCkHZy/9O0P
u8ompLKy6K55Bz2NEI/zPWImKyxYXF6jXXqo/iF2ght1X1jHURA0I5MQKFK6UhrR1XdGsw0C
nlZWHPHxcgG9Hbp8ksXe8610h3Ta9wF6b57BYf2cHadwtlM535+bLbwmOjR2EyfVZI7Vgk6A
hcjp+TTmp/6ro4Uw1tLVC0YMC+bt1TeEAAAAAAAA
--------------ms010402090207090508090909--
