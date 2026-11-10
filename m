Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270007;
	b=QAeRuYM1tpptCd3x9D4/XX2PsU82tLlMMo1SKxtEd5t1F79xUIKhkz8g4fDMb6xBz3N3
	 aX3/eYfWvUC2YAnuOFZxqn+Y7gmHypwNAkbscimu8fhQ3h7scPVjquYNI6Qqc1DHA3goG
	 i4SOk4LyxWfApUT5F7ef8lAqLW216mQsCfDRPMcN96jzfO31Dn44teiAnR8XTH2m+UkoO
	 f+2slx0cNpq3dPR7xbMdS+SidPIRNnMuXLp/nRtjbdoamWCGKl1km8B3pNPLuVJhelein
	 76Td0ky8HeHpOQw+ZxFq2PDuWZAXnwQcm1MlDBLbPbT+9tezWq3dTYi6exmrfdPNLJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270007;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=pT9f6W1k3GXbGng4/zTRaVLCKg7pFOTV2B4P2Ln+ti8=;
	b=cO0q0iLENI5uH84EO076lVxbtzGwP8+StC1z/NzLW4GaUSQeQky2hElV4Vh1StPXGnyG
	 8F81LzF1unuoDI2y9qX/50KFeP0khrZ+y6gnOAsu8X8uZEPsdmqQvTdaa9lqOdnyHKzi+
	 7kNHUluMFj+iU47zRdKM8/of2zw3f09jh0GxALgBaQesBeKssxFESAqWXYGHhMZqyXmiq
	 1EDz16UNTGZYqcy6s4jjJC1+MHr2K75uCY376ZbkkD6Z6klIgl1X8F39xOIUMe/iTUfN3
	 JwVTzomnBTe9ckDyUgTC9wrp8F56fgykOE2P3uhd+Ei+3MDlQ4fPAeAr5jQfdRYkbpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b="WDgHoX/6";
	arc=none smtp.remote-ip=212.227.15.15
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25DE60A261F;
	Tue, 10 Nov 2026 00:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E25DE60A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=WDgHoX/6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794269995; x=1794874795; i=w_armin@gmx.de;
	bh=pT9f6W1k3GXbGng4/zTRaVLCKg7pFOTV2B4P2Ln+ti8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WDgHoX/6FlqIhf8GNtjUjPRnQlQJshwK+SUVIUfnOtackjS4amp/a0fgXO0rog2Z
	 zQtI2d0qP6TZARPnn2/LzBcrThi+Mtc0+NiuhNTF1OUh/VvMcLZa+S8P+eRHFAH4A
	 HyWbK6Thd9zQGh/wYo5bwSppkesbSMtBAdzxhLckJAetAfCuNQEK6uDABR0OUKI0N
	 YLDL18f9FwE0yWkrUNYd9dF9kh4GUqTh9AKsqoZcKZZ6xR5KjsxKDsypKoBLnYmJh
	 AqcORViGSCsRoIsX1sodargS0kYsTEyt4fhz8f62nlj6MLwfGEuOIlnF6zhKHS01u
	 r/qKi3m3/Z2/577EWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7b6l-1xPmFC2lMT-009pn0; Tue, 10
 Nov 2026 01:19:55 +0100
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
Subject: [PATCH 9/9] platform/x86: uniwill-laptop: Add support for XMG EVO 14 (E25)
Date: Tue, 10 Nov 2026 01:06:51 +0100
Message-ID: <20261110001725.851443-10-W_Armin@gmx.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110001725.851443-1-W_Armin@gmx.de>
References: <20261110001725.851443-1-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:4nuDg98d2hZ3ZrW7DPB1hQbPmUOKvc3TkmG3ELt9aXNMP8e8rlp
 7Ky/AbbvM9Ewyu0FEiTcsfhDoWmRvVupXVIIg9NrKNX3FcYL8NAN+oReOkvys9vPt7n/AeB
 xTG0XfUwCED+JONROmtaPSo8mBlLgJVz2WoojU6nohvXhRD98UwzR0ja8LaayPZbZrINZhA
 0t7+JXrPyBbKFWUedcFsQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ru3LYVXQLc4=;/lyDXgKRAsw1Bx8xVl0HWNcZHxV
 twGJI5vabLCQWmCXq3Dts7DBRQXYtv/l+5Gd1D2XEW9mRi+J5TP5LbZwUP5uj9URDNsK4C0oN
 Rnh/A2x5nsAOAktTOWU+3ekakpFM/QsVqrU3LcHxBtcw0OOGh/61xFN17roy0invmaPqjxV69
 zJGtf+LShCMD4+qWI2cG5U96XnPU6+Q5/njhBUD8fi7y0XbKZU88VevjdfUGKYU6EX5x6dai7
 lyxBE2zgi1bgPTsW4SWLsP3q1soOqDP6cXWTujiAn3CMQhLHA0+rz+Q44UlJr9sjplAUGWeuf
 VXX0FL4fAVmEDu79zzwMKoFe8DHffZIOb87SnPN4M0l+lr/6N0Qv5OGk9dT9v5TVoH6aoWw3i
 xTN3QRwnzus1Sx83ngwFLCQSQnTz5CLgsiz7ciQnCv9SxBoDgevc0g7EcZf2VQ1VK2IxrmVK1
 Wp/u4bIixYE1IjmGwTBXH8h4HYjIGe7T4NcdYZEXIv+xw+ek1nzZ9IuEh1p/Ve8NLj1siBzgn
 aoayhyFAW4toYZj9zf2y319fdT4hYCcYM1AOiebX/2fJmVk/AVRfFvvyasOaird55OqTHf/dW
 y3gJidOxyOWt5QhmPpxQVJe+Vkn8dlYGlP28DZBjpi0Low4vfsZmLBgD6XdSOBsLN3MoIkGuX
 nofY0A4TMai279nwDzZplmcmz6hJy3tpyJvr/dKo6Mp60YXrUqgzoubRvZHBQ7FLFTHQcL9cQ
 LsmfbKnCURBFqYuoLoCOxK6xpAo0dNf540R2BM/BnfaLG2fL7QxkYTiziDx7j0RbuIdur1rpT
 wn+yBZC8xZtb0h9G6en/Th3PvnO8I4E7e5MLSo8CYE50oXXqYTehAvMdawNZ3Df5NOHY4BK4q
 yu6VIP9uBvSqJ8V4nTR0E5Rcnu+ZSf57894QS0wyY/tByQwSb1I2Ki+yxkpw92n2emxgjxc1z
 9KaA3ETgGKUejepvPQcyksHgWOM0VwE0riVMJR5fo1WIttpOyBx4wdWN0Ac+2IDWxnkcstyh9
 fUl73gu+/TNVPMjnKYDGaQ5KjfX9PHErUa6C/LH2TZvFFqJGVo98y774eI/XHarnXwlt0V+GH
 EcaRD56QKf2Cf9NCDDYcI3EmCXCq4Are93uiar+N98ifWuLyz653pocZc5ZRZ9Qa9cgTphoL4
 ckTRj5h4ApzCi9iFuz7CCDQpBSGa9xTj4KNj3hTRyZrPrJK4lhAeCPhUAlyjISeI7p5dMv8M+
 CQCM/eiMKZtYYqNyPv2IuTHMtG/Z5NsCXIyuRl8Y6Q27rO/VBIyMC4B0T0Ww8OSu1MKutzNh5
 eGSyk6Gse8kqiFsDBvqea8wmWwdpLoe6eLE9KHpxkZnq1PoRJ+Hxs1K0ygvvcNxf77xQ/Pljz
 SS5or0pOc2Q147Z5B3RLBRCbmwCnwI/fUZx5J9xmmToNPgo54q0a2eQTBuz1Ed0mMdonx/opf
 r9RfFTVcD611bYVcYht8Zh6kRLw9uBjTFzcqZB2HYRKz/215wQU11szDHnm1DfsPy9QQ1TEml
 peoFmae0ReX+lWB4zGaJK+avi/TWlOxjRoqHLYPAX/nVihk0o4EwtRqrR9X0uZaI+7pFlzbR1
 A7jhsM3ezDSnsnYbRFPhwknXNUeJnE/dIwqmR12NbX/ItE7fS8Qt/UoJCd8X4oMU6DMkYK2aq
 fe2lRtjfbNBLEGdz96LIWsLFE1bfApZbuwYLtqiOExPyfcz+YhLFQNLyjCWb2Hc+Uo5XWWHsi
 9P9J1N5huH3z88aOc5BRq+0rqDhOniUMPcquRz4C1SgYnEmbiYs3OJxtgT6pDhzmKHlcRhO+O
 JTC2VzzrPe+UElWCCP1ovwAAxZ6WiCnnRbXcIyusWZv9PMPakWK0Jew5Ip014PQgryuqw5E8U
 YBjeN6qzf18t9EImvhLQ5cXMzxf9UKk9Ep82h3udQy7YEg81vm4I1TsHjTIT4wkatKQT6pOJO
 8IWuH4PgU3pYywBXJbmNI/r62GFwIIk1Lh8aHvvYoAKzQpdA4h+kFpMKogU6TMLVrbzpEu3IJ
 1HXp1uba5LT4xPgrGxVhUZIf9n10yy1S+mtvrpICbJC+7tnjtL43GLcrE2007G9lCRugLY9zY
 lURFTy5RI7xHUTvOxo8IrJvTrVjs81pRnfLoeA08kHTRVXpKwUZAAfZ8pERWbfrVb8YIZk/Cy
 Brhwd/qTtfnDPVNuoV9/yI0JjLAMlBrXjhkXSYCc53Xsq8s7t8+0LxLSZvcdvJvy8PODL++ml
 g3mkHzL7daCkc6UazVQMcRNHgEzZr5vbdMNXO8rgJLI5J0uOklPLsrqmejlkZa2lg4DuXc7Ed
 fTf7CrUiFzfPIAvzXTjPMgMnFtK+lqNFmt0o0wrBKHlO8hsL5/faI70ht3BuDodtmLbj8Cxlc
 +wOQpOP0445QODevWfJ8RKhEl9wNYg9k4kQsWJV6RWat7c2KgQkdcHQ5w6pT6btYBKDx2mjFa
 dC/75aGvY0z+7/rBkw6aQlAWFypDzbKeoM4vrobJPXhmuIoW5TougbowqikDOASbYWq6gNkuo
 vp9yZmo7mrdaLSWUuQfPOBkTforWA40tDgAXNGgxkZeH+TiZrMlk+eJ4fVVl+1F/5SbLE0SUp
 DLl4gklNUzwS3FC4YVlRnYYrzNci06SitPz2s36wN0JLlHEKKlsrEUD1dgsHNe2gmK0Xlq6Ee
 47XMOu5wTEaQK278lohDK5nXn6R7fxbKoTnNrwNjUCyEAuKARI332/OSxZg1O6YADuMrOg0Oc
 B6w8f7ddaxrWzkK5f4QFdQP35YeNKmQU3/OiAiaGMv8wSZwJ+h1HcnOSuSjupaMOjDia2vWfq
 0iQ6jx9QFD/5ec5HvOeolqVjmZ6MMTCBUyAEr82m5doSzhPNZXOogM8ifMewka9EDpkzPOya7
 lhYWdCIk7RxzLbh4txWWH8fY7amSBJSciUIBTzgFUOLub1KAind6WbXuBBQmara/9n4O8BHYW
 ZJT/jnAc3YwKqbo3An/f83F8q53xSWn0hf4TmrOZ7jQwzmlDq+E8WVIyHu/iTxql+ppZ1qOZY
 Tw5rYfzhqDHDyZfSbNhlncISx9pONzwCZmvsX7xp8RADH1JbaJdcYG3BoQp+OU0rTqz2MDB9p
 VucNvLldjvDIRfFUqO8byVali3T08BaWnP3afyi1x0G9vla1Zw6xlPPGI207e3T38avzn4pKD
 Z9XxJS77zQQD3B0ZDFnyDqApB2JRmcO3jgSDU47hb1X21CPVP/fZaiYgCnhdGoio4Xln4vndA
 f83FaHm2DMYgWv13Kd8pN5ZtQ9HusuoL9fayUyboSpUd6mgT6kB2h+vg1XsCpB4KF9u7mEaew
 pvQLm8BpyJJ8bXQloV2s3x7Xeat+lrkyUyUkEp2F2ruNO9d2rXSG7CXoGSgqYFFe4kpZuIR7r
 LTfOzFJmFIyT26hHP488BVIqTZdM7hRU3CRSmhldiXMPnQHyzhcavpw02C+jjyUKnR8s+VhPT
 KgIHuLsy2SwpasMr531mvzaRGD03SwvJl4U3Jwjo2o7Hc/Rd+m8+4OS6BjiEhInFCNuUCEofX
 llXeUsPsloojdGgYnzBuL1sqdqTcH0xJymjiKEzby6ArMWUsCDm/9cl8MR8cAi2OYu2F5hzAS
 oW7Sl7hpF4mGmtRxZ4oORab/f1pqUVgzUraf4zRCMpcxcENLSxh/tsSzUm3upmH1OL+bxGgTb
 7oUmYSb9m/WN8w1XcjPH0/sxezlxFMzD8YsegzTocMsWJOn0ZBnLySWRjew3fVC2Lco6U2a0p
 sucHuDH0V77oNtEH3n7Pyt5oOJLVGq9eZkNPJa7n8RnE1t0KyPqV4bWHeQ2smoocZ6EQs5Vhd
 8LvwS9iNcf0lLGruOLbaqkuRyVmm7FWQZcPDQnG6/xCQnLP5g/lzL03Rr64dsNUwiCtOPImsQ
 EheJhX111CKUAWX+De0bxHsEfGaTLxkvw7PiHWrvSq0uH1D79Uhh6S8itX5229XPiWSdnHuj2
 M/5OhKiRUiUOOxRLoIcI0SlM8OZPaTsl6TIiG/dZsGpeswjuSAcTJhO1QjqCtdteIH4CWns2d
 4rSJxzY2v7jSzMbrfjwysrPbcUz3/0lQKhGtr14dBm/Mclg+6K7Y25psGFw6p+sYgsvx2OM3D
 mT23sn2WvL1oqEbYRqNmec7GCNHjAO8RvMx/5oqSSG2UGx/YrlkSXGWDkNjG+RUAXrKHT9DPr
 d//MF4dGW5iZ+kJ0xehP0tebe2i8JwAS3POYOjzjloL9EGQX6fNpqcQ3yYUB5Q4P6wpPi6J7l
 Dc2NlP0EgqZJHZ9tJe9Mlz/toUekWmnlJ6yEdb/N9Y7PA6qDOCncCzYfbqhfZ8eb3QysS+NeE
 Ju4JCenLFdYlcslktdq1FG5SAVN0FqKzjiwU3sN1c1iKYajqnDcAJ0MNO9c64Yu5u8pr6h1PV
 26Ag09VtxrxZ+XeDj8F0sabR9hr5HS+aXBoOTuce6o+kof52pcUqtrgTlBHav9KXG1WT/QkAg
 Alz5QrKFsBkzYiP0g4bzirqGWOBdv5xLEou+tjsAGjQN5uGaN7425xm8DIEhLE/MGE79NhXsl
 bIYZEjRkcw1ladNWubhAFLOwoE5ohbL2pfWBHx2okvG8VVukFh4egbhbFW0XcfHE9lAlHRut7
 Cm3+KljAcmUdGIv/WTyg4xBXy7+jZKrBHYWWN0Tu/XUTxe4OVOe9+/YT7paUW114vsZr46PvH
 h2tmqzv3NmjF4H0cBb7dCj7dx3+S5X8K03v0mSMTdUTKyCwKZ5iS2/jUUNY5cScKNjYY8VZPN
 Bg39X+znQCL4aDWXy+ACHWSXfMOQd2CbidliVrJwIvyRuT+75TgWYsnub8258DDnBO2a9ssbM
 KHlubWQ/7LrFpW2Gm3aPM/83SVEhxDcbBfFcJBvjU57evc/jCI+1Y2zMtWS5RmpLurnEyJ3Oi
 0D8Czv5zeFzkxkwP9/DlSkNqszGd52TfoKOBADzT6PMo7Sm5cMg4Wgx1Vvr3G7/yc3GhiQ1Ax
 W2MElQo0LMK1UO3ebWXnhZQNm+2j6augzMgVzJfFrBRyer4wL++iTZxvcQETwXTBcVs5mVOu4
 vpH3Z8oorf2uTtuJ1rPIjQIEj31LdyDqF+dXLX93cEm5wblWYb4Ib9+0FiKmW2cw2n9IAllnP
 RktIdgTYGNdPv8K/y+wTiMYQrVXFobWw9WSlbt6ON/OazClp/Zq1biu2Dh7mNEfapYzZQ8+C7
 wBbncijrR09UuexdkM7l5vSY33HX8tQY7iiPleKpRXDCWi08TO6aV8VcaUE1iHOFWXN2SNCF1
 y8kU2Pgbj7rkaT1e+H+tlUnpJnYGROkeTJUALpnjnVr81LX33x6Os5um0KuVqIaS/wEN10Y+I
 rMkdSK70cIHjj+LrxfibPQA2PzuhG/zUY0USxUkjnbICuqpiHJelp4vuV7+WUJdhBYkntstlM
 pwR07m7/CsqCigG/IXtmjuItsKlK+9tFiqf4dfKP2aS+SK3oV5kzAnTP/bkihwKATSoQZ7Wox
 Gkg8SKF9yoWWSOIRqwlTFOJdGOpQiihyncz+6i34KDUYghunpIr5628GDn/A4U61rE1VUme5j
 L9IlqiBl0xGvMPiAcZkIH6+iPOx3h9iAEO/myZRbyJwW1TGK3tVF33Ct+caTtINpVcD28HsQr
 KCT1aj7pBOVQuDModZZ2W0IBLIAKIhEaPGJohObBnbfBM6fU44K0svjizzukbSGSpyHU4qIdG
 c6iFqUmehws+/dGbmE6YDzq8ft2HokzbCrag2WzDn0LZcOY2t4Mx7myCr1TdSPj7++MQE/R+u
 2BGG3g0ehQJ96l82TTIGB8U5VkJVVb3iIelyO2FQl1LcREqaiWVevoioKh7QuHZmI40Bystdq
 GKMcjXmxv2lIU2vDoWzns0Y3p+IJsnkgSVHLxZ5U4aaNJgciYYPNA9nnmThM98T+3h7I2Bp4U
 +xCHKpjdtr2lafpvtLfDHAXxLKcEN6LUw0UReFZU/LW7/6mqmvKTjoTei+AcuCNKvUAnQeacE
 R6SouBWCrAWquh088OG96c7L/VZ/RvgRWXFJBZHXhXcHy++pCUB3+3TiAJiIaKVfy7+7aRNRv
 gKxSlekPoTuWD5T9vvU0AbGP0A+vEK3hljOq3Bu6nWCIsmtYfxR9TZrv9n22IOd47U2HASAxV
 5u0CaNezPs10wg75YckDRh9UXUjK5lZ00squvzSoB6DQ4QJs9v6Kak5dQl251d53CID4Xsu99
 TyBzAA4HROZzftBG3FXtP2TKOXXunC2ILeyP1/eo6YtbD24lueGEc7gw8kDtROqOxFsdCPKL6
 1/cTbdtOSNRCbSKYQa3VWwAAKwp90XrF+DVMXr66dU6qwMfdvau75PTVwfFugzUaOYhd3X+uy
 4Dclw3c2BH+FZxj2E2AOfLlHU2j8ZuIQF4ZO5sZy1FF0H45mLYGXLRZEhF9W3cHm+yjWhmVvX
 Jl6/Z6btte+ONWx1BWJI9U+6lJ/l1eLwhDlfN/7ibL3MivL4fh9mo9g34IBHh9TcycsXEm9fs
 HsvzlJ2dT0qpHG69ZxE7Drw7Iy8cgbw5qMsdE538qdQ3Brc8RbfleXUAER29USsxP8QONTffH
 vpi3crRpPxLYYqCD5GWaQpnOJA0Pdo51vauB/9hqxrlZbTQcfkSRiG+Z0VSEUGPHYs9ne77Lr
 EnwRjHJJJ+LyJmiLE1w8dOFIIpeAX32bzFSC7b0bv5Hl02CrTFpJr3tq4W5X6lPFvjb/HKMlD
 19Mj3E9BeSt+/hasWHZ50IdW+8u4XVmauGDGx+Wuf6BJU2ehAHG/4XZ8qkAGtQ7lo0iz1rQwH
 SAIeXscViuXUCN4Jb4UubKN09zOTRsSTb2XBW493DQzumywXQb8SarSZZ0Ctf7odpZqDruWsc
 NaSselyNOiCh3Gphi5Dsq63eFMLZBbDaWhd7/CTN6WVuVLpqV9xhTU/OlwxpnO1yvEZe/cqif
 jnRzGbSy7/3wJykFcVNUN2YUWgnvyke5Bmk/DKJvhJ+IMIUkIurMAcZB/OiOgXeoI45QT/LsU
 VsvAznb4feFXvO0Qxsnj23W6tsGNSkscqZW9nipXwAGcW+4LWqNJe7DeI2Q09hnXF8jYS8c3N
 5VyHEwiuO4UOOWaqM5fYsQ6c5pIbykLhchdtUOn86XO8u0pakLuxgLl4EstsLgcFLmt2kgv58
 hhiJaoqPCtsOMX/52qD+QXj5794Xs65EoZFrujrtE528svb0neTnFjPuNkQ+PERsbAU/PniMr
 AoZISNn6ZR4EwmhFPOdNJVTbjC8QFn4ShqfTJeH4P9z31sQNj5/9oaJ3/YnLmtInyHqs49FCK
 Cesy/jkSi3Q9BexGu5q4BQFRoRi2qgpQy0mZ2zD5o3xwsP2GUUtK+2/9yfkUIpRckVqvq0ivW
 kkIs4+WCC6fz4cr9XUU2Woq6UJ9bV4Q4sY2uDYm+Bc+75Cei+EKQP/x5p1bfKPmf+qgLprx4Q
 RM7dS0tNaHoYAkV92kq5JvMuj6v8eiOVCChkIVU8luHlR64ailqE6NM+hL2dUDLY9xixJW328
 H7T82CF+xAW5cCG691w==

The XMG EVO 14 (E25) uses the same board as the TUXEDO InfinityBook
Pro 14 Gen10 AMD, but contains a different manufacturer string.

Add the necessary DMI entry.

Reported-by: Nico Kessler <nicokessler@icloud.com>
Closes: https://lore.kernel.org/platform-driver-x86/7FEA1980-AFC6-4A6C-84E=
1-E820B7E6CF3C@icloud.com
Tested-by: Nico Kessler <nicokessler@icloud.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/uniwill/uniwill-acpi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/uniwill/uniwill-acpi.c b/drivers/platfor=
m/x86/uniwill/uniwill-acpi.c
index 6b0138246599..610ffb8d76bd 100644
=2D-- a/drivers/platform/x86/uniwill/uniwill-acpi.c
+++ b/drivers/platform/x86/uniwill/uniwill-acpi.c
@@ -3214,6 +3214,14 @@ static const struct dmi_system_id uniwill_dmi_table=
[] __initconst =3D {
 		},
 		.driver_data =3D &lapqc71a_lapqc71b_descriptor,
 	},
+	{
+		.ident =3D "XMG EVO 14 (E25)",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "XxKK4NAx_XxSP4NAx"),
+		},
+		.driver_data =3D &gxxhrxx_gxxmrxx_xxxx4nxx_descriptor,
+	},
 	{
 		.ident =3D "Avell A60 MUV",
 		.matches =3D {
=2D-=20
2.56.0

