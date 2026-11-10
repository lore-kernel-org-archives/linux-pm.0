Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329622;
	b=AtgaOk7OMLgaWufcF977d8oIb/1IRIM0j+tXOYlLsrjDEbT+nOegew3c0BW+F9G4zY1n
	 1FHcpJBAZ8+EjFNi4Pcs0Rl5zXR9CYleQ3cpe1SAsCZ/7Wrghnd5FzYHI7unry4/kw4/y
	 IY0KUmCJTudCJXU39kHA1tsKB3dRzo6JtwkC+0qzgd6WpkLEbDlzr1NFlljWSXoGgzSLt
	 /qxU8jrGlYZRzbikYY0nQkpDo4HnTxrGuA8A5tah8G1PHF+Ll8oBz8AQjjUtqOmGL2sq7
	 i1TlvK2ErCIYdJG7fvB5gqiTdUBFdhvNkaXdhNM3fdeHVo4h1gwdnW8AR9mSC0b3zRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329622;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=hULrbJGfxN1aFBxrCF1/tspKsEc7TI66kVN/0eRNgNw=;
	b=ijX6r8/WRcUvh18thWpbRpD0byz/swiYKzPPoH83E9s0utmCF4KpCKP4ed65xzwoicfQ
	 tFu9VsoDlerjY3+vyhR97D1vB46BsNmD798cri7727CTOEuEtjPsH59nWrNds/rGcNjhn
	 8XR11+CAbhl9Pxt3MrLjmjJIoLcXdRwc76pJzOhszeY53wqwkVaAr2nzpfHXW6bl9fr1R
	 ucUzqVgbHPXVNGpJED+KYfQrY3yYdqX74VANN8tOsUxp486UX8rN7rDAwOc7B5iDj3BiS
	 UdX2mGcAXR7BGYAzPfXNXpX1+LW2z8y48WNtBR/PbzDMuQpe1MPixs7R09cyF3Fgy7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=ivRoBLP+;
	arc=none smtp.remote-ip=212.227.17.22
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E1460A382E;
	Tue, 10 Nov 2026 16:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1E1460A382E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=ivRoBLP+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794329612; x=1794934412; i=w_armin@gmx.de;
	bh=hULrbJGfxN1aFBxrCF1/tspKsEc7TI66kVN/0eRNgNw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ivRoBLP+3fJE90p7zr65XcRlezy11QVFO497V5G1NbixZoA6ovFLvkoOiNQSch/5
	 nHzmIz2npAIodKxq0g+MHtuMXvVyjv0pzesSuSUmdrIuS0wk/ZgkOkboR46KGLH7j
	 2qb0uFnEH/fgwVqqy1h9PkzqzhOWFo5ofLnSWsRlkEZ5WIDre2AIgFhBtbGd/n0Og
	 UCH2dIgD2bfmZ0RoEHuFOoYhIRASaCjNzS0+a4twtVhhoe5vVwbHU6/B28SIU8IEq
	 EpGziwE+b0TPkZfS+2r3vnztwiAMHbO3UAJp1yvY9ZPie5zoRDQHjtCzehRQCOZdv
	 D3AVKtaScSMw6fi26A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLR1f-1x8Km835gR-00YeJu; Tue, 10
 Nov 2026 17:53:31 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bifangknt@qq.com,
	nicokessler@icloud.com,
	sre@kernel.org,
	linux-pm@vger.kernel.org,
	wse@tuxedocomputers.com
Subject: [PATCH v2 7/9] platform/x86: uniwill-laptop: Add support for MECHREVO Yilong15Pro
Date: Tue, 10 Nov 2026 17:50:08 +0100
Message-ID: <20261110165318.631010-8-W_Armin@gmx.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110165318.631010-1-W_Armin@gmx.de>
References: <20261110165318.631010-1-W_Armin@gmx.de>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dFRPyrvyio3D76Kre44XSscevHT8pgBQPinLCczzNtLbxTZkuEW
 3b0VLkETBUoAGSGrlXb2Ld3CAiutsiSRwC1w1WptonR00d8wDJ2Qa2cnNtOiV390q/OAZZp
 hzSMUY/hLrJmbTAEoa0pry8MS7NHX2BCb5v6mzT5AEWbwZWHrpqXJ8dKllXtW+HpcTjufzu
 AMtCj1Buk7eWTQ6XMmD6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PJSVwFuIgnI=;AdrLE4J1jq+V6Hc5MtCagirz9q+
 t/JUMUH4sorsO+VHLSJq4v6CbWsQ9DpnDYMcxKW5lHlI1ZW2PblxUW5+WHqFm9eaN56ircKrD
 w2T7EK9kGpvnQHPAhlHYUvRvgy18OgYGoM9/N9oEdUcNC0d+9xMOo+FqBM9+ZMcCKtXepCzJO
 85q6+txps0IaqeVZQU3PTjvPJDCzNd88jyjlQSv2YOyiJ0UuAq7ncidatTZhhXU7cVdPmwIdU
 812UghehYjWEn3JY6JzZK5YxPpOH7pkfXduGois4R+wF0MALq05LHRwBFiRJuiMaxASf1yqur
 74gzN9VpRHu5HNQG6UMFRzhqItCbsTqB6lTpmez5cp8sW9P0O8UFmvdQxey9ldQvpycN7pcTG
 Aqn5zjPFQEGi/imcokRU++3MPDMrbYmzAIdOPyXkZt5szB6QJbInlHg4hsFDuDb7d4v7rq4fy
 9IRvk8IIIMipsYLHBsrRKhBdSZTqByE/wSth/DVmtGlGez1OAVKjpzkNzJk4SWFR72EQgR+Jh
 sGwBcKtYORtKe9CVR6vcZDcHEANn6uxFBl4yOqlQ5HInX0NptWUEgBy7uNuXHZhJSuiUj3ZK3
 H25UGymoWaBH397jYVOttOYVzz4G+u5iOPwMKkJrcg+0MoZL83uQk7GdHhxDsNhBT3bB+3n6L
 pfbT9RDGB7YJr/CQrfjQAEQo4bIbpwJJP+uhTnmVCB/xDwjLEzURRWKY8ZmTwFCw8LN0TX+b7
 kD8dB4QvlQVqjQKuPwtQDaeYGjHGSrdc+o5H/BjaRjkUisG0R7JnMRdKiE6yuQKQ5amgavIHc
 KLAcMiixdHb+iYOyevxKVlb5w0dvbbZHk2UkNVc4/b7i1Hwfd5M7KQy6BrnNqY8j4KQgSh/3s
 z3btCoSLel4SRA4tcVF1OaG0vVcbiGBUrLh4lZWxMEzrwsCQpqjrJBRcveTAIdR2skdQfbKYG
 CK37Tc78V02EQ2N0CIOFkqgngzXGEv+FU8feePI9Ra+F58qm3dvhgFJS9Qii0YuH637kODbNi
 j9G8i5I4/drxxgfwQ1VvbA1ik0q1PLl4/IrpiLbVJLJ4GvztxsXp6u5uOG3/hiMKB0Sct7wCm
 tw/IzX76xNj9fXNdVW6sCs2XFI4lDCoMol3ydU5Ja9IlHvJAWXuQ790OPYasKjdh41yjXoSh7
 LO70BcaNkjyxpilpm64ZJfE4iB1D2R2DMJZlLFguNbYNDXoFeTqY46Ep7EqScQvzaBTJELmbQ
 skcTJZ2ligUov2ryIeS7tVrA/DrXVnBNYe3GfUlonjBik881qrjug56HAbo3Rz0sSkgpS+CzE
 vNWB419K+0EnIwPLn1SSjdlC7/N/B/+oj9WoPnaafVEOB+3fuvxTfR2Z4yYSSrkWKTts5uj+6
 GHt49ZN7n/fmE4VAjrc8G+/vwV+MCPwzsniemIh2ykM6DsrDCEnDHzgjIlH3Ikc0GpgX86Fa+
 WKClKDWQBXn6E6m9ZKEXMMoJXzctfBHXXPqot+p9dPYJL/npmfnohLCgCZtRxJhDFNCV7tphb
 a/P4h2LGaT+5H0aytAYPFweHGP4a/hCPzwUrgZzKPK71WLkyXmKNH3n9PsOr6fFB6om2kClxN
 zhkeG0X96+NV4KT2t1aDz41jkwbUPm7V58dREpcBR4sML+Nls5V29cXILjgATyRZS9SrqGj/U
 cx7JV9v0HnECHpaS1QbRUlKTTqKp7Uu26X/XQmtW+0OOcgjE6gpufUtaoLbWwa4eMtOKAhggs
 rTt+kno5tcReww4Lu+mTtOj+Yrh+vOV6qWlqY7Kb9zrxgIDJ0w3B7z/UpUN65AEXH/J6j7IyZ
 XYI7OrWvsv3GCD+Pafl2rVKZRMQU+MQ/Qwsw7FfyBhc5NH8YfclG77NWYwiudQNEgiQFPc0kd
 SiWEA3zS5asp2zRb0YPL0Ngt6EAbTKQgPyUb223w3E8wvQQJA+Gh8yZRugvGPmwPzWnU6kd+y
 8nNVkruBKAfaEwkvyx/8kOFzryS6aSafQZtyx7LlvjugHMmtarG3RWD9PckyrwDRCooE09epG
 uxYJud5NMD9dRRDtu9uRAFVHeiX4gCwaKYZDZHlq1TVf1YAeX4/BNBnbX4OHN74cg0qXeO9rk
 HFcbjAuFCUBlGDn1VJmiDoTtW334vaHDfqk0yHjPg01Y+5kqnIaYqDZ+fCg3UYFBZ/froY9Iv
 Oq+ndD56gwZD5vJklx6ngoO7YkfegIHfrzpGqbBYIBSx02b4nbwMhK6wUyPI7uIzxtA9Oy11p
 97IuClbVqF+mEhfFmTzRDBElpYZ2sgoJk2lPogB0kVPuvMUFqMChG/ccCi28nnPHx5CZ3FCTb
 gi+OeSk136naiyRUPt2j0DEpSXRUg3usD55bFDYWqy6RcX0fnPcqR00XENl7SlOcfPDmsr+bg
 RqNjYpt0r9S1QlWoByg5GXnNKeGfHT0kysZ4aWA8NyByO38yZQAz3iKC5EBqmz+EH4sbdvMIL
 s8sDGVQw5B4E27Oq7/ljvhZNy1smrWv0tduS2N+ku4IxwCMuDibcE4W2FyeYCQesHHEMqnFBH
 UVCgZ7m8IxRAj56nAn5g65dNOWmgDc6vg5cF1UTqvNB+/0sJ4Wa/j1Ahq5PE8wjhF+auENQfW
 XV9Pijob1vPNpZspp6fCm99d6ep+qzcMxxDhLhu4ku+NPDAqRyA9Rq8vb8nlUyPTXWllhvIYL
 C5PX4i+GNGN5FzvUyNSoLUsKfwJ4oxbcWfTkDkx+9e90eC8OeLOh8wr60jjOd/OTKP8uO7zcL
 C5MaAokFRDV7jm9hzFVqAQL5Mmrm5b7S615LOvH8CDsgFMrGVDd8JHW/8CbvcQHSGuno9/YKG
 RocqPuEQGTFr2JN2blYxW7gPP9/AR2NSTuYqlG9lq+rPEn8ABhrFrooETq2JGUkucd+Xc2buj
 6Xh3jCikH2xLEFpYlNjBndiLQp3axWhDbEtRqIwsmoCh63nyMn6hW7g9qORfqOlzYcSpV1ik0
 /G8OC+NGYt6zUfiJcrVNFQ/aTQG9/79koddw0Lo1Zsrn2mzj1z60pI2gZzgLxFTgwNf1SP9Jb
 WN7ZhZ2WFYKGYlhsVu+z5kTwTXk61v6TqCZzZNWJAY4jwnFv3jS1q/1N8XAGLZAiMU5PZLwum
 YreGWHmc/aUtEnnEtg5w4BY8ZOTLnUP2lXgT3PAL/m3n0Mhyqdg1kFLwSzVg9WlE/x64DdgXj
 VvImb5Soc2ihT3tJBkb7wsnc05rF5uzvZ4VfdxLZZFX1VljmCoHdko/GmFwTqrGfd1geFYS6g
 nqPtXOzodgtrg0UjrK+amy763xR7p8T8L5q7qGNDsWkk8GghOTFfmjgf5yZEcynU7dfYdP4cH
 NmmX3PVcYfQrIK7ilXtoseMquIirDWqZ7qE0fxBfyksJrEtTcODtSpr/twmHZmM6XULAXIgZC
 Q+Rinu2SABwkI/q8ZaWlBqKBdk9/9jLcvozegqEU7B7VP0dT0DA2XDbU2zO9sbbUFa4T/2n27
 +GMVZp17NUEnu63geuFPfJnTj88EfCiWlZLtt3nYgf0gvWpDWKrLbwvTl7CYW3uMylVIaugzL
 mQvQxBVereRTuPOgzGdWmmTvxCmm6ahhsSN+jeaiK4bEQeiXnebesNJ4ye6r3NF4M/FfYS5BZ
 r20rmdM/p/o+fw4M5x8iZrq57Wm/Gw5kkG5XtGs+MW5J1zJGKn+CsaKONv24T5wE/thdcmJyI
 Aur7k+cQdR/QI8GXiO9ayHFqlYtffoPoUrOyRNgeJTpO8zfugcAXlEHXKhxpQE/QUBr0+/Pl1
 tB1dRvc2mmGjqgYX4l2OM/gn6FfFsYW3JAcmmqFrpXcfvDEr8+UQI2Du6LwCzYnwE/ELK6B37
 vIIiKhi+x0VXI12IfZ5aEgPWKJQXySjBCah2TVbOC/pWEZId7rHDZ3WRNGaXOozBzBWMA3yVH
 AMcqnNxA+Sp9FNfX86dSg3KXHtlqKOaT3aBXotnF3LsKhmLQ00AOu1OkGt7zv9x+1a/NTZ5Bq
 Qh0XvnBPIL1AyDqnNwEfyr9i31rdCbx4R8ds16fgbvOV7rKJLGpW6YVRoPU7jzq9d5V4KVV4E
 lKavlYUM4Txn8CpUid8aFyZGtOcQCHZsdRXxhp9xEAhsjDcxN+ENKjtIy8kWKjhXA2EqSOmFy
 y9wbMKow3UBAy2Ey73RvEq+qWBdy/Bga7E1DnJLyLatmOBN7/wjCtIGhHsaaJ/D03wMWL8bMM
 pVnXa28zsaSVGMB9Rgh9Wjti4Ocjd0XH2pVBpsiLpXJgeU+MrYVpUn6IwMnYm6c5bVRYbQli3
 Y6NG2iO7S5TdBpQY7S5LpnZnMxRhHAU2f3w3CLFajFie0Zh5a7J/OJyn9qBew4lWK0YlWQa5e
 PSWq4Ddh9GcalF5BBWTBYM/s0/UVNwUqQ5cOEyUVvM1YH8BCZjCStqCiBNYFtjyFS6fFOhWZG
 NVS7ABLuS0kC7wQkIZPjOPudbkKnaStiz3Xf8TRx/q0Ivw/KUteuy/cazs5LqBtV2JoHyO4Vc
 uwMCuzuu+Ph63RwEhzwfAXIEsOMliSNRxKAt0BlQ328IG0zHYfj0LbpjfM/Qyn8M4W7edLYLg
 YKeCQnDZNvvehGQjdPUyWyxtwoIwbAY3F2IKc1dvFnwL0EZcjtkUDhE2vqOILUa6X2pNBShqK
 n+hd8PbaueBCHjDaDyfPQtbirY5jMfaMH+/ILf0zNXotbGLQiRlrHPUTPpEk7/J/h0lum9Rky
 Tq9ArKQ4wIRCVNvIZKTlfZ6NdNppb16L1kf9OK1aW1eZGyPtt9kEQc/owgqVbXT77i0rdV/c/
 S51FF8lfTTIhlZ8JoPt5Hyj7vxgfBRKQRGCugq/407YQKmsOMC64/ap31Bbs04OfRdgsp4WO8
 louOjQY+QGa1SEc+0w1jR+Cs+NWRxu1iIeUrBv9S5SMeDFFQ61GKSUIX+Lrm0YvWuHKHPAj+j
 kz+4yD15w354sLVjLVefCn9lfo+b9+b9Mk01xWMlaE7BhMkOT5d2WWlAvGLSmrmuGgLfPveES
 RhYIOR2JElaQ2sfg+4j4ZnY/vEbH2Aq5YT6Fk5ZKHME9+UBf5Ptdh7uUBkh/n4baEVZR8WcCc
 jR9qyf//bqQdkbc+7znrAPtzo0zijjGn6qRjlcuvu20rWiIfFL8SumKnZe6sBCUDecuG9Vv8T
 UUE25cuWJZSU34OzQX5zD3vBuvDfOl0R+LBPjCdd9Ui8w02azQDriP4x7jM6S1gkg4+hKOtx7
 i/kNvCnK8JJE7+frsSdJK1eAXo7fLj2wsaBcX4PYsS6CfQUr/JhQYSwKogG1GzGTQZcfYfZEG
 ofwYiU0YkaIQq5KlodhBjbSL1YUpZXt5jABH0K4nTKLNLzvTVEISjVYNRWIkzATs4l7b+tFkE
 tOWqlYqQ4X6tcqfGM/VeeFAVw9zyacBUzs147lCr+AYuP0PEKaQc/0KIpOPAXIBrZpO4aset3
 1OcCWBqkDq5QDoGcNf3RY1s3fm8A1rcx8Pd0/b8+tWUxpKoZfWSVMWOoZrs9q37wS6v7Bzjzj
 O9utZsQo/JPO6WR6jqjKDmViytczqbquYEVtcCKYOkxmnc58zK2Vrz2NR7Av2AwTgRRJF7ybZ
 cEtOoPZFh+0x1tOSf/FnNZgqaBj8wcZMpIrxejlmVlP4ZHks+PsX164jxFFBq6l+mwercEDH0
 AJHR52jWKv3eKK/JUZf6FFWDnztDJsCmgqT/kQ81j+Sr6IA+N9l0AV3p5Y5e8cpD/a4v/HOE0
 uoYP4B9S4Fsg2ZtxAwxkKPZeJ0vEPCKKEb1Yh8tT80NVdMvt/Z25O7sj1b2iTuaA79KV1sGHr
 WrR/9RoivRyf7kWB28iQmLMlftyZSIEJ6DkoZqE+7YqxciB3D3HeO6KYN4RSAb01jc5CWHjW9
 riXpUKUpHJXycvld3sRsfMXge6AFJ2yEkHI8XFP0iRI4FQIv55PuyCsc87AFG4wGJAbK/PttV
 st5OLTwOHkBNpvMdGyk1EzGe0ieNnMmXdlmy+tPVDaC8QK7Xm8IIYlKKfTmeWNWzHoHyQeX7s
 daY3owqi4+JJQ/YAdK0heqFUV4HoCyQKivjq0G1vo0kxcQrZrEi1MF9gd7we+knYvVgwpwonB
 piahELs6aUsUMk0LcYiEjpkFSBXN/e0mnndN24qI4/Tf8cDx3V5oI1tGUI9I/w91cjfcQM+2x
 fdNRKjdBmr7rIm+/miMTOHyw1h3p5okZLXA/KLVo44NS626i4yojYYkaH+8p6AkSbX2AvfctE
 +ONGQOLG3IhOa6nyIFEWB05HiuqEMslOmdvsfCn1a4NNQm48fyxLlIaPjt/kRdClGpr/apnOG
 WvorGVkHm7UFvWyuFQFJ26J4iSQRtWijri4+P7wXf6Pzs2RKurw5D+fgpN3EZ7Cd7japm/M0a
 R4U8cYHiGJZAeriYlSwEeF1Lz1v8P9bg8TXf5idzYo0eIRX7ruxH0ri3iA+KekzLCMrFk7mTl
 bistcQbveNkdxO3mkVQZePRZOgRbYoMJNe2k13S7AdD5gQeLpRjNyB+SdcgybpzZeYDVehFAW
 MZ33E9VW7l9JAJMi4jxkoPi2+ecN4yxNrfTCdAp3lS7eysSzYpF2+LGcTFQShqc/usVHszxq9
 npcRA4IuCzaoGqhd0ekgS7UoGLqAyFHqAqeMBgEzW9rFW88+5m0LtfJo6mS/4CuysmZjjJD88
 Asxd/g0/RFqJj8lK1qOKAMZRa6+TDXvRM5r2JoGZ/acOJclM2/B7v6izM6vxc9N2iV2/pit7i
 4wMdhfQKpSaZ5kqe/8QA+RxPH9CcJVDBqk8qJcFzxophsSXh4Xp2taJDPojxz3IoUDWR8fSKY
 ObI9rzXH+mOCy4G0DGilfQ3VS6w5gXr0usfMSwCELYB5Ee93XoHwJgqjeqd8KfdMmV5onzftW
 AnobgEkfGkR/q1DzMKxdzxah4/eVZQR0XKJeXG8PyeHQaOSow5+rpw9SMgW3P5wp9oP/LY9gD
 9NIbZS11r3Lp8B4UevJ7JGpCWHWAcp2pSsuhzdk0bWUTKPwOcCF2rc9Rwycn09mQHX7YISZeM
 /echyc/l0gz5ObLTZjHAM+Fr7YQVqYiBmNDcE9SsEN9TYKAeP1eVpAgVYeK7X3T48iH9qW2z5
 67NHYS576xj1YJ4z5CyJshNjZnLzpKZdxN28uij0YnFwRFj0P0sdz9pVaSgylcJcxdrcus+L+
 WcVUR957e4+FEd4SiEIKWr8+SzQT5LwkMzQY7aUv1Tv/sO3bxwL97fJzBzCwyjWPU841g8aQu
 gyFbD4KPE/4mKaJxzc1S2bYNErVXHo+phh4T9nDehtOoAnAxdVV2UrjpJrI3sM/4qBMk2CykD
 Lbr2jRcbMhR8U+OOB4nRq8tcsHlLbY3CSiEb21AgtDIiJwSBWpocdeYblXUBpHlMGOFkbqhud
 ET+B8v0OrNFZkiwpj+EuMvj/+Lez9A93PZwW6RJQJQhTp1AKaN5xBnFv7RR0c6W8kssEZoiT/
 jVNS9VYdrv0abNRfVXPIOWELVUIqOpMgVP5prr3/1OxlnoOYeRsD5NaQ9xngdT1DAvapO64oy
 nBv7gWRy2w0RUs/xC4YCvVFXxb8voqTt2RkRM/fI=

A user reported that the MECHREVO Yilong15Pro works with this driver.
Add it to the DMI whitelist to let the driver automatically load on
this device.

Reported-by: Bi Fang <bifangknt@qq.com>
Closes: https://lore.kernel.org/platform-driver-x86/tencent_D521DAA244039D=
BFC3919D4EFD176E383607@qq.com
Tested-by: Bi Fang <bifangknt@qq.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/uniwill/uniwill-acpi.c | 24 +++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/platform/x86/uniwill/uniwill-acpi.c b/drivers/platfor=
m/x86/uniwill/uniwill-acpi.c
index fbb704cf6e66..b71e7a73b4ff 100644
=2D-- a/drivers/platform/x86/uniwill/uniwill-acpi.c
+++ b/drivers/platform/x86/uniwill/uniwill-acpi.c
@@ -2781,6 +2781,22 @@ static struct uniwill_device_descriptor machenike_l=
16p_descriptor __initdata =3D {
 	.kbd_led_max_brightness =3D 4,
 };
=20
+static struct uniwill_device_descriptor mechrevo_yilong15pro_descriptor _=
_initdata =3D {
+	.features =3D UNIWILL_FEATURE_FN_LOCK |
+		    UNIWILL_FEATURE_SUPER_KEY |
+		    UNIWILL_FEATURE_BATTERY_CHARGE_MODES |
+		    UNIWILL_FEATURE_CPU_TEMP |
+		    UNIWILL_FEATURE_GPU_TEMP |
+		    UNIWILL_FEATURE_PRIMARY_FAN |
+		    UNIWILL_FEATURE_SECONDARY_FAN |
+		    UNIWILL_FEATURE_NVIDIA_CTGP_CONTROL |
+		    UNIWILL_FEATURE_KEYBOARD_BACKLIGHT |
+		    UNIWILL_FEATURE_AC_AUTO_BOOT |
+		    UNIWILL_FEATURE_USB_POWERSHARE,
+	.kbd_led_single_color =3D false,
+	.kbd_led_max_brightness =3D 4,
+};
+
 static struct uniwill_device_descriptor lapqc71a_lapqc71b_descriptor __in=
itdata =3D {
 	.features =3D UNIWILL_FEATURE_SUPER_KEY |
 		    UNIWILL_FEATURE_LIGHTBAR |
@@ -3134,6 +3150,14 @@ static const struct dmi_system_id uniwill_dmi_table=
[] __initconst =3D {
 		},
 		.driver_data =3D &machenike_l16p_descriptor,
 	},
+	{
+		.ident =3D "MECHREVO Yilong15Pro",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "MECHREVO"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "GM5HG0A"),
+		},
+		.driver_data =3D &mechrevo_yilong15pro_descriptor,
+	},
 	{
 		.ident =3D "XMG FUSION 15 (L19)",
 		.matches =3D {
=2D-=20
2.56.0

