Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5729D18A6CF;
	Fri,  7 Aug 2026 06:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786084849; cv=none; b=SO9bR/vYW0ERRXeGdCf51upFQSnEeJvqmqNVfLI1fZeQSVSfDaJF7OTliEETY4M9qP1dEHCAT27A2iQVkerFK4NTcLKwgcRpvb5uaXrPfi5VwIG47/o1l8Xs/X4znXyUanTbMIuyBZvhcYfVF1weIFyjfLn3ar+dMvcHWbB9NgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786084849; c=relaxed/simple;
	bh=Uu2yxfYGMTlV6AIkuI7Bk50GiRAdX4wrgCfEy+STOX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nYHPzpX0xmX63rgvxq/92bpWw7WjG4dNlPiplP/ttSnZQQmzakcJfv4zaOPbHze3/h/FYjffQ+/dwd3wIFedNH7dJfGDj/arbKvby12yeRvxajsU03KwG8FIawfyEmR9bSiahegv0JAVG7Vw+9ed4ko+Vki8Nl6JRKkLn2LWBtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=NjwkHhP5; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="NjwkHhP5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1786084839; x=1786689639; i=markus.elfring@web.de;
	bh=l8xVvU2F/fFUSSpqRZVrd3WQpwZlkQIJEg0DhUYBh/o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NjwkHhP5M8TGZW9jGD2QxOUcax2Gu8ONV1zT/v86VjnVb/QnKnGjaE3waDwE5Lqr
	 LNNihC6KzujOQJ/5KCUuNtCH+trhbDPJnQBKRZr1tXoxzbUkA9AvHBU4vEASjZi6Q
	 ZnTVRjzA41q3hiZYZYv1W0ro+y9W66QjC7LHA7+9rixSS+m7YVB0MqWqv6tSRpQas
	 GPMXNEDBzZii8Xv6wRA5sv6mmuL39VFZYrW80lf5lpslHaY2r7uSTGs4lsnet0rXe
	 2+5EQ+E6MIXtgNNnJ81B08hDRzc+4BgKFJCccCzYRZ5BsWBDK2PSnKP9VfTkk7NOs
	 GdVSVmuEdG8n6YaX3w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqZQY-1xEJPG3iXQ-00kazQ; Fri, 07
 Aug 2026 08:33:31 +0200
Message-ID: <c27214da-4e76-4b5d-ab86-ab03beba8f6f@web.de>
Date: Fri, 7 Aug 2026 08:33:08 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: tools: Use fputc() calls in some functions
To: lkp@intel.com, acpica-devel@lists.linux.dev, bpf@vger.kernel.org,
 coresight@lists.linaro.org, kvm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-perf-users@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mptcp@lists.linux.dev, netdev@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, virtualization@lists.linux.dev,
 Adrian Hunter <adrian.hunter@intel.com>, Alex Mastro <amastro@fb.com>,
 Alex Williamson <alex@shazbot.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Andi Kleen <ak@linux.intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrii Nakryiko <andrii@kernel.org>, Ankur Arora <ankur.a.arora@oracle.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <48f2d61f-d468-49b7-881e-f00777db073f@web.de>
 <202608070547.MRKfa3bH-lkp@intel.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <202608070547.MRKfa3bH-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:heSIkINqyeiTt9/TVU/2HaIToPYra83aIuf0AvbOJOpmzGssabi
 2pB+Q4N00ikWy96JtYbAI4l92VxDK1eIhjSpkmWDfXgFHRUQ7AnWMM14fXBeSUbUtrPT8vY
 ocQ8Oavw5OBRE5CCpreC0Xu8PbI7O1BHO5Y74x3WyR2UhRH9v5EgfFH9wSGPOPrV+FzK6Z/
 XIXRX7oHnEmzadhHoTc1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:k5xmCFqfYnc=;FPhBCzsAApmszVnTY7kCXnMutFZ
 aa2SQll96tx7ETsRKtnYfBqFozJ4AbBrrKyBv3AhbJL0fkhN5RhBAON18fV6IGIS/mr7cYt2B
 woZTP8dsqggdwFVnLvpwihZ9M2Rm5DOl9zbNtoUIx9n0wtomsCnvLxa56b07cX6UD2WK6lieG
 vQGCOjHDPdePh/t+Gir+n/rZEnd6bVqJIIwel7FtPHFQut/C476oNF6RBXi3FEyrHWfvFkwxA
 f6gtVBwfoohPt3DSC1eftDrORjIgr0LZLtbocRlaAOI3kAZ6Fy1sg4wMb4BjPWyvX6DwdhY53
 +4aIKHvIh3AbgTfcCUSRZLb2nfTZKoeDvkSVlrTY9MulXPwY4q8lzGsbWU9arsZqjoZ9YGJxg
 cbCIH5cXwR0pHuo2Y1U0cZmFMZ79yC3wOwehiJYvYLl2KHwRbbWAVkYbgko9CNvEjTIMZ7EbQ
 AJACbD9l3efK4Zo1VbdjshnmXuNHBvtH/yXwpU8Lin92GINZdyGAPm/GLNs58kj3LK7nc03JO
 V0DW7mSeOUH0QngSeKpQDIvxC+ttKyofBJyB8jfoQF6TP3/jPDIrZXCBShrve4yr1PCM9uLDo
 MDLyhRGAOhi++zBv2AyeCFxS81ZmpgRgoSnfZmLhkEP5uYZKGFOe8wuIYug3A3Efid/2XQm/D
 xW5ifb/y+7ZM7wgCFUstH4Gl/9qVzN78d2CPJ0X6IhzWY3Cp6R5yw/DBl4e6YIY2a3xThaACQ
 ze19rYKtWGyvCQv1YakH0iqZ7lZ5r4XMBblfzHvbjS+vYlGzI+hMSVryTEK2ctsKXqj+2VMwr
 eDyJcziz0Pp7LW0buG0Ecj0AiCvoTHnuvfuM66E1+boe+S/zy8P58GA8JA8/DX81L1YDVLMXh
 ANkwiSFKcRvI/rWH5Eds39WtYSVZ1QhaSJFmcZTdu5vOrQiNoXUXO8KWZc+3JZRlKUfWs8kVx
 GTkf0Lyip7CDt6ffi6HA2C9gMZrso+fiMbmxJJ5wpUbzEXIeFePem6C63Kq9KTm8rKyktLNkC
 XFLSLFJPvfmQ3n6SgEjI2lNxBNmG0KN9JV4aRNoAc2HHLTwWEBBDOr2J9o7l+IZ1TJ4zpM8wi
 omKjNfCBoW0n6fDPgBWKfPShsa6YR7eodWWu5LlmqN87zuMaUYeYznm9JPjy41iYhTnlA4wpq
 NR+eUiIPwPORHvsjeFB8ni21ojVNrJJG7AJvDiMMag5KWJLDYfG3YUPbthHWbUdEOCEqb8M/f
 Kcjoxv+QSLXJFB/3lzLmN+29XuuA2gKCrmvTJKcsKY2yUt9eaa0ygRERK/wISfZZQ4HgbgWnq
 0togNgLIfMrXG79FgNhbANwzRrLB1SKrspA68sHBf9ZLZVZHFbn6SqWIE+vMZUGQPRO4f8Hh7
 gEfDFW814qDaCo/Hvpn8ryEM5l/lrqrnVl9C5SrGg0knb+s1UCfHBHH8jDhdDJGCqMeu6lV7b
 WI5ayQaktft1fold6AucowOLoQCJrcvVDd8iCCEYzlWOTDnECCtquBPQvDm6pqI/KQTGqwm7q
 UdeKdwRV5MvDaKWGookRSwhd6sdyjFaytsnE+CxZL9MWX7xFAgvWHsKabRXgyLg5ymNongZzl
 Y16iZNU6e7jJi8RXfL4CXILbczM6mf9gPxywYT0uA/UDpUuz5mGUsOyXhpQiDQDRxEU/Xf6dl
 +JyE8alCs/85homIM2D7vYq+mffqdHHCQY67+cippy1SCWr/IpCjnBVPGP1jMPGWn4QsicmOf
 wmPATIaQD4MnU3bJ5hZeUEH9qSVt4YKqCynqPrdGmCY8JW8WRCQ/h9mFy3I2vYAx9VQBmo6XY
 TrMHTuMzQSTrucR+7ebJ874xsQHqHikqZ6Murhz+G8OGmKBqfvQRCd/wUJwpEhjftREaxn+Iu
 /PoDgjkbp5Ytv9TPqgDnouIv5aF2jIDHTGCUfgT/yBgfDlmoLuxw3vOQO+lMc3zFkuCjSIjo5
 ibBCVsa1Zc8sYUW0V0voaCreCvSSx0lPbH9RKdLxCiyJ3HmkoldI7RjSBltbwwKEUPy42c1R9
 Q9wcz8znPDHiVvPM1O5wSsrVr7z9ZxvtTMBJBBR/LoZmqMvkjXzE71zQ7EZz/cEQP9WPUQpg/
 viLkgZ89pctph0Xvalf4e9I05H9KdkhtqN7GPYQTZkyVyo1wHKI74zzo6zYEsOHqkRKF3BYdS
 Nz2W2fnV53hp4jYBoQiMcHVUCkdlsslIML449r0aVPyvd78M1LpamDBUdo3As6xMC7YjpGF+G
 4OqDHGddflvAuAsAaK9PVBCFvxYhepYUSIeiXsx1dFPy2a3DvMDcgn043jPavUD5mExr3Wib/
 Rg/m3dp4DRoyVBEVG8Z8wYcmlrT5HnkkwENapkH31HX4V9E6XMTPcr/dbvHvloNytpPfGeyK6
 1TuMw2yfv5dt1g6bXM690uxvwiFxQ+z+YuhNiYofx0yP9/NN6fX3wftsvIq+9ILBYtQH0MVod
 fXBLLx+6Fcrre2iwl0JEyaWNuKbzTDRYs9alttC9r9mUAFfZ4hBxDTYtnllC4rxKKYUJ1dfeJ
 MSOLl9zrJoSu1+h5bxACvfZKY3CD4tP17Ba7YFCOhTPPA3AeTWqr2RVlCHs9NJm7xkU1x9Isv
 fWuHiukT7dD2auSNSIeWPj4RVEmoIc93Ypc7XYgt98Qtxc2TnkyLsdf7ysH+ZV5FnvZmDZ2SE
 wqijjBa/1OnG33jK22aQLdIDxt+UR3Nom63D9vEWQ27SsAi+cj+DhUjRXjbSaA00jHKditdHb
 JswLbwvyIQF02+QYp+L+TsEBpsJQeY4GvwIW5XxcbSOJVb+hEKULJB/d1YVMHkHVIoU0TAwMI
 wKJCmoZl9vg+QyxxMyM66EzukSZz9nLSYSt4FhhR7kI7oTvX4stBHH0bmdqhqp7PelXvA7ev1
 +fXNhXO92nebwHGnlFklLOuVMO09T1V+8I3UILPZM/WeJigOfL+TlvyLxtKeUqnOoW1p6brOh
 j7tE6nuI7YszCUZ8MbakMl/28SD0+Au7MNtSDZaqIwigf80V/u4mkcd6+qrppHbsLWZepnzb3
 3CU3MsuPKPvETwc86/Ut7FbXCjPUTVah7Q+7BqK7UY0dIT+vqJwzLGkPOci7cecvUP8uCs9zQ
 jBGTR7vVQGR6iQJssBPyxtsOjamEBX9g3wqSDLAuZPYN+80QSo/1M9r1qMqJJeVITx4ow0Skg
 CDGWA0n5IH0aylM7gIn1pIUDM3qGumyasSLS09rxCv5cNxKgAKeuDGR/WvbISo8YbqB2uZ4fA
 xus4PaD4rU7fPilH92LIutuXGL7kpjSiMFFbe3fGFOhRbC3IVyYtjsRqruJutoyLfsH8k1MNb
 UrL1TjOyt5HW5fSMTk+Q6Jiioz/WaL0OATK+9AazHcpJZ3Xme5JLCapKlLHC2PR0J0RGdg4i3
 63M4+5zOnKDWbAg58ay0eC19LH85BK3yW4PUxh535hCmLPgy09HF4ZXhSoiNgYmx94WyqVa+L
 XyqDD+dPqXLKE0FTaToXmuYnELwOm16b1+HbGsIjmmfI4qFTgHnJkJ/Tij0O8a1E7lKlokl07
 9C7lpQzXHnc2tgbl/WCWGHr2tmppSe6JhF274JQ9lcED+WyR2FCtjrqXRd20RMLsVTowJttKW
 tn0VIWx8HqELZ1q7zEMcANPW141HoBog7TFb/RBxfxzfgI1r+5nqji6drz/GCUS75Cvfc+bNo
 lM7F15dT6BjcZyv0X5bitPK0csfsINp959+TKC+nSryb9FdfDXx5ahM+FTaqZ2kkKiPUJQRqF
 tzQ4HIMfPXLag+Dc/ukN47/0QGTcmFLYxqsdNkv8+tbMl3n6Y4Wx80V5cANKE3yo/DMzZKz/K
 0HP/L1asLe2drn4Tf5HoUsSLKEf6G/j3FZYtH5S6poDv6p3Uz610nujHPH1B3lsXW1FbrWBZ+
 kBT+6co6inPEh6EKKej63JOz2CbBbZJCnIGFyUEvYKcnZTT4yUYb+GOkUn4vn0ZdROsehJs7s
 86Ars0vMKnOCmawxFBFEWZ7pU9R/yqQdpPN96drFDYz0jQZx4Z35UvrGgAI3k7gEXQWWh2cED
 9scxSqUgC9dcHjnEdUQSrUX0pHyVxp2qpYWfth8Snoi05wr+fWHIkrhTqXZ1S0EqbioCcJyTb
 eozn0ZFxYAleOupajO5TzD47TM6int+ALPIVlyFZl4bKZEKSghlnDS43EyflNk5PHZ55fr0Ip
 egj4zHHI/T7qoSXRrXrMVpe/lQdbCOtpM+jYVtQ5FviaZfArQmJlllPPhpn+h+PcAWB8LDl+e
 c4ZiTDyLrbZo1ykeSHC2ArEVCQcGT/PHYaBSEps7w9cXkNM43IlqD56JBVRUwhASSVy1Cbamj
 Cypd1JHZCeoCE06OOuoN7OKAe0irf6T40eaf3k10jzgxAPetsa5xWd+O6x0hhzYuBOd4RLofA
 iFD4UGOUBRdT4TburEF9VgQFAOLpbL/eSGmO6GRwP3k7mM7EuKPW+mK1unkT5cbdJLcvyA6Zf
 StYLNkyKeLWtNu8Oi3rEW+04wrqLghCFji25vAJJntFw0/nr28EF7vJcUPnDolFCiEjzeTCC9
 FtQuyL4h5ozUAy6GNC8WYv9sc619lvfGPnNFFZCCFEvaHArX9huUlxI3xBkavstuSja1bh8bF
 AfoR5sQxdVxjJ5VECMW3Gxv83WIi4auRrSVxkxPkB0Zx5afGvSbaS+RuUWcOfnaKwhFBdR+rE
 s4Ej/9BiV6Ebr9OFuTmTuSP2DFV2jeQy72kYGsTaAitUWhEqQQz3gFVe3MgusqVL672N5gXlt
 80XDwFp16DfJjmLOSLz7O40eXsQLRNbr6aEUCDXsNPYsp7E7KabURfqicn3lGo3HjIVF/eAf1
 4/651ejcsYWT93jCPdynrJP95bzfbOCbFkDmh8LlgVXEJ/bAb+wovY3T0n9FoPkcGejnYDt/j
 S1ShbomFOfR1lrkoxCOM4cFN/4g9mKPi13wDttntcKnxNCjhfPkyE0/K3MOCeV17Di79857Gn
 jxTOXxVXmPRQ3aVkQa2lSkuYeGPl8UNcGRg6JmafRKMxtJs5hpufkLUJtRfjhuUZUhPPdebuw
 5iC6Uf5l0SjJ1nqpKIgsZT3A7aW1Kh8qOO/LOUGn47AuAOpgy1nQqS8MRqbEWI3utOx0AL73D
 F1QSV2D7kr/U7c06kMpioyyj6UcQZhFpqg8rK0nnrJm8o2gbw7e9YXbHk0xco5kxUM8HQy/JK
 WKOnzEPORyebStcdhBwHWaGrO3Oilc1fOdi1MtfmjJ65paeEaSVmIgqnielFVU6sDDULknQTF
 jIpkkIvMamq2cBQZ6psVqj2ufOZSlSAyy61aICMzV0zx8vFC/QrcE9/pawTePm3rispKH0dSO
 J1eHcn1HYe4Cev22hW/xkT3ZIN89NCQy0Spdz7LMw841bO9ZOHP/ScQtqBnnbT/8Sf33AoRQv
 5vWOE6arUYNgo+mYnM+Ikiqj01LsG0So14Y8tJf9JyJf0rnJmLW33jR7TKs/VlcWcb/16wJv2
 2X8JUvLaNDVBQKgq3SXlZOet9/yltTDEs7IpIqhVpHgWVud5csAV1QVHZChaC0vg682OAUpPv
 nxrvpce+fQNU3BmmLcMWjkx2fq6AAkGg1v9IHasv+QyBY/iuC5GEzpsot26DF8ZeUSmWjo24k
 6w+Mfh6pzcIGLOWyWlYsRrHwlTVIr6297DwM+TH9X/ora/KAAwERt9Hsnfjre3AP49q5iUGWJ
 xe5aWDhwtuLJbFdBebn15kaCUfE4ZGiUypwizBImcDrCh904qNGA4JonPtBbyOmh5eEFyUUc/
 uxgJMa/NQndLN2VXZrqe84WbywNPwjmxxJdxieAafhqjzG4B1nAejMTnhTAfrXz3qEAmRrU65
 XmdwYGC1uRc1y7LcWULQN86+I6sdi8xh5QJk0KVQaDNkhHIpwmRZiPiKPy9Ea2zYT39m+bMqO
 ayqR7dS0mnlTqE5ymNg2yqXnbd/ZtyDLWP+J+cM+8p9dn/dZTKdGgTEHgybl6ZD77HxGCoDTF
 yOb3Ra7voj9l2Xm5gSy8qAzFEYS/rXmMa5bSAPWC9YUgMNARrLBwnyhIWN

=E2=80=A6
> All errors (new ones prefixed by >>):
>=20
>>> builtin-check.c:300:8: error: incompatible pointer to integer conversi=
on passing 'FILE *' (aka 'struct _IO_FILE *') to parameter of type 'int' [=
-Wint-conversion]
>      300 |         fputc(stderr, '\n');
>          |               ^~~~~~
>    /usr/include/stdio.h:155:16: note: expanded from macro 'stderr'
>      155 | #define stderr stderr
>          |                ^~~~~~
>    /usr/include/stdio.h:611:23: note: passing argument to parameter '__c=
' here
>      611 | extern int fputc (int __c, FILE *__stream) __nonnull ((2));
>          |                       ^=E2=80=A6

Would you become interested to take another look at a corrected source cod=
e transformation approach?

Improving output for single characters (with SmPL)?
https://lore.kernel.org/cocci/406093f5-ee7d-4ae9-808b-2b42d4846eab@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2026-07/msg00055.html
https://lkml.org/lkml/2026/7/23/2205

Can similar adjustments become more helpful for further software areas?

Regards,
Markus
