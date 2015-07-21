From: Austin S Hemmelgarn <ahferroin7@gmail.com>
Subject: Re: [PATCH 1/1] suspend: make sync() on suspend-to-RAM optional
Date: Tue, 21 Jul 2015 11:36:28 -0400
Message-ID: <55AE66FC.6060509@gmail.com>
References: <1436927091-32520-1-git-send-email-lenb@kernel.org>
 <55A668FE.80409@gmail.com>
 <1A7043D5F58CCB44A599DFD55ED4C948468A7978@fmsmsx115.amr.corp.intel.com>
 <1684935.fYtBRJbzgO@vostro.rjw.lan> <20150721093806.GA23841@amd>
 <CAJZ5v0gNKRRaXvfqvj4YEjb+7X1aEobfvWuWyAnAcKArcxtZPA@mail.gmail.com>
 <20150721151941.GA19581@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-512; boundary="------------ms020604020805070603030904"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:37627 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932700AbbGUPgh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2015 11:36:37 -0400
In-Reply-To: <20150721151941.GA19581@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Len Brown <lenb@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms020604020805070603030904
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2015-07-21 11:19, Pavel Machek wrote:
> On Tue 2015-07-21 16:41:12, Rafael J. Wysocki wrote:
>> Hi Pavel,
>>
>> On Tue, Jul 21, 2015 at 11:38 AM, Pavel Machek <pavel@ucw.cz> wrote:
>>> On Sat 2015-07-18 01:54:09, Rafael J. Wysocki wrote:
>>>> On Wednesday, July 15, 2015 02:58:22 PM Brown, Len wrote:
>>
>> [cut]
>>
>>>>>>> Why do you need CONFIG parameter?
>>>>>
>>>>> So that an OS that doesn't want to change their user-space,
>>>>> can build a kernel that does what they want by default.
>>>>>
>>>>> Originally I had the config parameter remove this code entirely,
>>>>> which would achieve the same goal.
>>>>> But Rafael prefers the sysfs attribute always exist
>>>>> and the config simply set the default.
>>>>
>>>> Indeed.
>>>>
>>>> And so I'm queuing this patch up for 4.3 (with a couple of minor fix=
ups).
>>>
>>> Please don't.
>>>
>>> "OS that doesn't want to change the user-space to speed up suspend by=

>>> few milliseconds" is not a valid reason for asking about million user=
s
>>> one more config question.
>>
>> That's your opinion and I beg to differ.
>
> Perhaps explaining your opinion would help here? Having to echo value
> to file to improve performance over reliability does not look too
> burdensome on the users.
>
>>> Affected users can't run mainline kernel
>>> anyway, and will have to change their userland in non-trivial ways to=

>>> get there.
>>
>> And I'm not sure what you're talking about here.  Who are the
>> "affected users" in particular?
>
> Who does enter suspend to ram multiple times a second? Only android,
> AFAICT. Can you run android on mainline kernel? No. Can you run
> android on kernel with less that 100k lines of patches? No.
>
> So who benefits from the new config option? No one.
You mean aside from the fact that calling sync multiple times during the =

suspend path is wasteful and (potentially) puts unnecessary stress on=20
the hardware.  All userspace that I know of calls sync() at least once=20
(and sometimes twice) before telling the kernel to enter suspend.  I=20
will accede that for some people, having sys_sync() get called by the=20
kernel during suspend is useful (for example, I don't use any special=20
userspace software for STR on my laptop, because it works fine without=20
it, I just 'echo mem > /sys/power/state').

Also, I'd be willing to bet that FirefoxOS, and whatever Amazon is using =

on their tablets and phones also suspend multiple times a second, and=20
some ChromeOS systems might in the near future as well (and ChromeOS is=20
pretty darn close to being able to run on mainline).

I would personally say this should be default y and presenting it as a=20
choice should require CONFIG_EXPERT to be y.



--------------ms020604020805070603030904
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
cnQub3JnMSIwIAYDVQQDExlDQSBDZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcN
AQkBFhJzdXBwb3J0QGNhY2VydC5vcmcCAxBuVTANBglghkgBZQMEAgMFAKCCAiEwGAYJKoZI
hvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTUwNzIxMTUzNjI4WjBPBgkq
hkiG9w0BCQQxQgRAp27FW/tCN99wtiO7rkOQnGq6a8AYSiznKaD6tTMiL7jX23yHKrcGLvK1
hG0lgIeX2kA8BRPCrb2Vr9yyL9wpMjBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFA
MAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGRBgkrBgEEAYI3EAQxgYMwgYAweTEQMA4GA1UE
ChMHUm9vdCBDQTEeMBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3JnMSIwIAYDVQQDExlD
QSBDZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJzdXBwb3J0QGNhY2Vy
dC5vcmcCAxBuVTCBkwYLKoZIhvcNAQkQAgsxgYOggYAweTEQMA4GA1UEChMHUm9vdCBDQTEe
MBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3JnMSIwIAYDVQQDExlDQSBDZXJ0IFNpZ25p
bmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJzdXBwb3J0QGNhY2VydC5vcmcCAxBuVTAN
BgkqhkiG9w0BAQEFAASCAgCWxXDMB69YbhArx+Xc+mxPa6g8wL8G5ua7GmYvhyqgttQqnw9t
L4dxyc0cJCO6IMUR+fIg/DbfZp+/6+x+n0v0OthkpBPEXsfNAXS3205jFEI6OVKYNzUoCA7m
JPhWlAQs8tCijqmeHFWBEm5xWDLWF1GUbEbjFTOPLFjXEBw0UtSeTVHm7+yN+DoguGW82HBH
KOnpy1xPlTlnv5uuJPZZamo8yaB0b65VgevwkTc/6WPWIGF+TsayPzKYg7QQzm+Kh9RX0m+t
Spj0/i3/Mx710idOju/RYErnSvhRGZvhWs4oQhSlQGJ8yn3UcNRljZ66OwRL3QmF8RWlxQSP
ZsqsPmWv4l0JwcqVJ7MGDAPei1WcPZDzHeB5SKVb3+wLGQHibDjT0SsJOVW/obwkZvVFqK5T
GOQl3H8rtuqeNVaTohbTB+RAZdQrM0Gz4Pmo5ykUenPZlCJgOP3bGcqZ6dSqgcPYkDqrp4S2
kK/gEyiCtE28wa5d6loAhgrh5UeXiOkAwWH9MAimNY1lYBWl8QUnrC4kNTKNh2Ey5C2TSANR
yo+ViWE7ogMcPsECQThyOUp20BzcBQ2SEqXkSLLWKR/hSbjIPhgLwvh1u8lUXzH1QbXNUIxy
Qjz4JlpwLVPh3cB2VOlP13FXqXkG/wjJMNj6UsT8VrU0QyYolFDo3ZDOEgAAAAAAAA==
--------------ms020604020805070603030904--
