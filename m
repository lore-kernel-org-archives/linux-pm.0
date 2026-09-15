Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA1143DEA1;
	Tue, 15 Sep 2026 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789500057; cv=none; b=ZT+Wm4xYXt1P3PCUnYghvHPSO2BD9cnfJHekFTI386YrWIWSfo+e/HQ+QpxyTeLiAihelcHyUPN7+0i8y4pJGqoyVduSaQZGlF3whUS8Olas8QRvotWL4IW4IhCO7O3IRUNo+ft2x0Vhhm0kt1Vncjd/sH/tkv+tpv/1p0DZ0KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789500057; c=relaxed/simple;
	bh=3dYTqMTOtv3m5K5bwYPMulkTKBm7xa4wYqkVVTqK4qQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a86tinHE+gvNQXQLL7kMhce2RZrLYWO33nJEEDP524gnLm9jD/qIiI3Bw8fAIEzzHwFIEUXPuBaM/nK19asRABdArbamqV2TbeYkMGg1U7LWo1YE0+gBlV6+FacTKl5FkCam7Q1uXah6RFd656HRzzEf2C8/ereaGIG4v6m+7yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=lbVTw9wb; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="lbVTw9wb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789500045; x=1790104845; i=w_armin@gmx.de;
	bh=PPuFUINuhV/rG1wnVX8mHFYWiFz98IZCHupfwMFolm8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lbVTw9wbyX2NDL+nMPkPRqbIqQkdTCDsU1HF4oBQvqVU9ncdvu4QXtUzygtPVht6
	 nnWZVQFsOSOVChsxcaRFe21yLfmcoqYHetcURbVZ3Smjye+ZWzgBj9Mxe+fTDyjBO
	 6N3OY0bARFIE+whzSTxGksaUz6mmpdRxzRN3bSy5vRpHjej/NUHywjAb43bYaNR0O
	 QHENFtJAsxRJO9d4hZvkp+qgfozXhq+IY1z0haPCCsVru3KTqbRR1lEQi+DXwBP6s
	 hB3Krk8y4u8O3RwEhvAmNBRHnNXZM09JR2TBHE8DnvGS1lw+62K4HBjmC+d0ryBrI
	 bNfm2AXiFVoIuTj7RQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqb1W-1wSqBZ09Ee-00oqQe; Tue, 15
 Sep 2026 21:20:45 +0200
Message-ID: <77b1542a-5f3d-4d8f-bf97-67e2c2805927@gmx.de>
Date: Tue, 15 Sep 2026 21:20:43 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/10] ACPI: thermal: Register thermal class cooling
 devices under parents
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Hans de Goede
 <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <1965933.tdWV9SEqCh@rafael.j.wysocki>
 <951189ad-71b6-4776-8484-a207f1efe415@gmx.de>
 <CAJZ5v0gLWT4x44Vbruaf0cKWp0jPTkLuh0pLQ29_O5vfNC4q_A@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJZ5v0gLWT4x44Vbruaf0cKWp0jPTkLuh0pLQ29_O5vfNC4q_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pwNkncHwmr78olvv9wFxney+VYyEHmG2TGci576xDE5+P8w5q6z
 XzAAh23+U0sibBFUS1jqnBeL21p370IMb9RaeolQDjv9CO3wttFKhdzEyoynRvKBwE7QvqE
 1K0Irnpv55vNk8KygnSWUrcKVv14Lj43IvGa6ie72CnfFTSG2qcxR/gfbjAhiWtd/Kja3kF
 PGvxfdLQj5Wi2WrAjM28A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZXObKeBDjWQ=;T3kMKJYT3OZECq3G9+bBpcVKmD5
 1ynRK7teuBgo68MYF9Bdik71xDZ0mVehHwhsW/sriFfEj7jmExxXUmfdmLN//aan8mawGzelI
 d4chxEFZA155yEUOAKp4CuDlSpLRuc5xMK6DVrRrUAkNR4pP9G43tiVsh1bcvoqp0KeYsK2QA
 Qv2rnWUWsCzd/Y1ePo6fquLUkEjqclz6fgXZ2VgGWuS1k8tp1U5fGdqIFcxMyscBal+mGdgPt
 nrQeBfrzOjxn7xQSvnqPAeuLmQ8+OGS8wxEW7fLyzm+jCaA9dIfvNQ3+b0+7TRaXEU8EwF14v
 Q9ZLBGiXuKMSo5BvIYS3HiD6Q54lK6MzaIB09Gh/uTS9z9zv8oZmYIBCCeoBNNYLQzLytp/2g
 NJouEVglMu/Uucw78HaqmjL0c8n8Fd4VXDc5E+y9nMXN5W3V5PZt2MbyXYOsRrAbcOojNW2HM
 dM3qzcaxaaKe7UxK+40ramSgvBOYNnCJr/tUymtdbGy99JqDRPwSU1cnnS/CPgNoWG4xKqmd4
 dhXkqyOstDRW7pZ8yYD5VmpPa4t27ed7K36YO/HkQL8lK36MPPT3iz+xTbqxv+a53hR+gZ+n5
 WAxq3uak+hF6LrjJyNPqX9pDyQNCGzHmOHKGvoGaSP38i8YibOiewzehl0HoZePIcFdk4fykC
 VJNCvNrTBmCa9QNlTE9efC7+s+ZRcHHULrWGD+/jhs3sUP+T1JKHrr4h+SLqWERSp7dQpMcPl
 z0y5ei8pmTs1sAyRQEf4edV/uy42x+unVQtEc1lPt1Atw3ouftlA7m2xN7OTVcWyUQgoNrvaB
 a2tCO4lKcYFLXECNC/HuHdETTm0swz3TvDY3uLV8G0a/WLgQZ4mLKlhOtddXdVDQ5GwpCLv5G
 BmYoe1dum9AdrfceSQJnbJHaBJckMsjx2x2mhjQpsc4UhF8tjt/Q3Re6ZOpJm0FRZLXupHcUu
 52YLzfLzUNkIJfyY4/FyhauJNcFXK8/w69k/3r/YZuq3xrWJlZom7lo3nDtPbVQ/iIjpm45fF
 2aNboOqFF4se3aV9y/aO2aUkMo+ddIlcHkWjDpOMX/9etpGlUD7QY6YR8LEDoYv29jxg4ksAC
 scMhI2n5G0Z/9ny/O8w6xxydGwJ/nPRJ+a7it9C/cdEFtEsZz+Be54FzREYrZso9Xsbm6o3ka
 qmIbswwG5uMHXviZLM3fnxrXbH3O9llld2inGBC6Pa4s8OTjaL97mFpitIsYeJ3oVLkEXvRcc
 ZeP5/odxWSKpvHZ4g7W6Kitf1c2OxTuf3XoS1jQLwUvKw80ehMI1K+kS9yawZ2SXjt664xFah
 TrY/ENNOa3DHQ96aYU+QwBXSRhTZWdyQhdNaJBe54vcT/nokgyuT6cetaPr48yO3G1jyFfq0y
 3ED3ft0Zq/0noRFZlq19B3RjWcAUOLyLamcNM6JnD1lO9xqG3jk7GiCdNrT/2kjM8nvagaaDH
 vEVbLgtkKR8Sx7qvVVjeDstC7DUl4vV74NccB/DQBAGClW7CGAEhS2Q+A/GS1DEPJWfjCqnC1
 JDft7M6hitZtAA+qOkd/F78efNeIwZ9TygrvGqVfxDiEJPXTGsUJDODrt+sGbeLytINM2sqGw
 K+7lJqm/rSSp0Y5Z2k4NIkKJa9IvXmj+WkSpMKILGyYdKsM0nMkHEydCeFNNYP45n2F0uFlfm
 RvJ9BEVpTH1MUIYTYfrim/u1wsCuU6BKWpXL1BzY7fUko4nrfLtopL/yPBNSpPP2IgYIAKzIw
 wfZaaNmI3WnxEiuMIASHit3LvPtkt2dpb9hTtm9HeCex9SuHl+7yhczL7fr//tYDt2O4Mz4LU
 IarRNVRscjKlqYdp8RycezUKo4/MhhjC+XNk4eR/ErCRqZSL+P6GqFgO53Dll/uLc2RkqLF/r
 NVYwqdSE5Bn5D1gsttEvCHZnj0Kf31wFUpfgYOi1NQPT20tpNBRN/d9eBObrFNXa3Eb3qVTe2
 fNasZuFsn3kZJ9p7KqaFl6nvzsWxosq0UNf/fdZxhxsV+8+8h3MpY/gJ1xX98IFM0ehK5YjxN
 9oLzgNRRrQQn6acnq4J1IuNFSNOW2uC/FGJg8RzOniZ8n76dG6Tf0C4d45s5gvdGEt3pyc7cB
 mdxRQTeKqThjTIVbaBLFxizElHSVwQF1NiIk1/DZlMoeQGckF8qS+tjAUp5lphI0Gel5Ceq4H
 xtbYh2htNGhtWNLLNLwYP8X9dDQ36dynCHfdu8SPT/hZJtLqBQpXC1P3tl1lvEn4SG8F3vmaP
 1LFz+nOJKOgZ0HWrlF9GmRRF+tVmcQC04emFv0DWe/VZH/p5r5FJ/FxTed0OTR8y+Q7PyWqAR
 paoZL/N3hq7rAc2u2xwFyHgMShUKwBDS3mvElN/nhNCn9ZbLOCj2bHWXVMQjjv5if0+uRP5EN
 /x8YNMhCas7sJfKQgCJXAqhzp8Da9Epc4cdX08qXi4HweiIZWnHEHcY5oHkK0uMhjgBdvtJ25
 VRNf9HZ/D45yMtIeVoISJ3IwunlKmurofjGgiX+/7Y7dyvKYxpxVZKGpMwEDESeoKDIWpO2G0
 FyUdBfqhOj4/X5YNeBGfpkPS62BXjUUUGhM+1opLSFNWJcWlzkuZm8rQKVNH3qsVtHVQOxE4h
 TisK+1kS7CqdJ95hauCRdyUxbD+dWVNcTX3ex3+mn28LTI2gtjXHXUsRGNp+/xDrGM7symcnD
 kb1S/0wOtgmEPkFa1PV1OFekYeWPwWlNB7dVsxBRk5RyAfaPd8WJewwf0TJPNkRy6Oswvao3m
 cgTqoITqaFF1E17eqrIHAow0FpIcq22jNYB0HxuHInwwHDvNZ42ntjkX3Txq/raXCklDrsBDs
 Mi81r+YSpyo68kM/xkg81pQ99AsIR0Q4HGdXpJG7FgKtFNNmENxTRTdIvxSyncsCmww3zSGdv
 XbwXvFeoFktomZszc23sQzo6c6FPmkHfCjrS8AGv1iOHHD6Wn8yajmLOIbQBrXgEC2P0l065D
 g2HG4gEmxIBJduiX5zjaT5gN1EQGl8X7g9UhoV88me6HuCtDirlpKXFhgcw4PzhQ63A6b9aMs
 hkmsR+qI+TsoWD0jDfQLHOj1tE9saXNBqIy8Ry/wEAxj2fVVCZuNsPHAanI41tsMm4SyAU3TC
 V12zk0O7CJm/bthC53/JN6PHdsiMKVIyyzEQhxnEspqc0mYyXa5cGs1cnH/vtTMKN6kU3Fyu/
 Rj7R/PGgLGBAls5Zi9dP8f5DhtwSia6VBXD1dffKa6r3UAfpXusbxjb7axwk6+ibr4chG57xn
 I+pnhBol2z8ivfHkA+W1D+8d0Nsar3FsXovk5CzMW5/UdOVf74zF46en+HRLoB9H1SonY/p7P
 fHLkd1ZGMAGiFKQXBKwMLrga5Qag5gVtlB6WjLEPQz8QkueWdU0w+kE06rEYc/Msw5rANBDTo
 LsEMPG/RcqV2hPsfUQ5hGZRiZeVFinya6pe2wP/UNrYx6AobNFitXfgmNblnSRLUxH4JjUe+o
 HMq16cZf6in1/901g3zt3Amcn8qRSSLj41PdZseYd557JVp7rLruT879fkEv7Zq7O3sPQVae6
 iGHBPcX2eyCtYa27i9I6tvtLV8VJz1hPaBrfsRl7E2BVxuFK9Uscy/50DlOENEJuXulQGVkuy
 XyOQlTiW1zG6dWJr2EzKBbKf1LhIVCRmmcHfieI5/5JDQ2NITLx9PanDgIVAiApxW1FBealvY
 wxgcICOeqg4ZQelHoEBKRmH24yzv3mR2IZroIy3yT0xwt0P+ep7PBXxPCTJpq7QgIsaFo895R
 gr7S2msf+aa/25tVPoAj6sZ3n8mbf/Cmi7oM2Iax4OLQttuUKXKIJNaaCM1zZ7rjn2A23KpUX
 1FE1UdYkU25bmpdnyjYi56s74J4NkrUIkcv8Da87efx3ZZBP6XYmOztv8HRPuSnmWFtyZ07dk
 DySkz0zRo0mjZQoDjE1Xi8OIoyh33NQLUSbMUZKVqV84z9KKwJet3KYOQkyMl5a1erU5R5QB+
 BtIMonAebnBhNsAfx6iWtt3OEdWkiD8sbNE8sHetZSt7r7C2r1b9Rk5SHuSRxGeK7G31Sf2VJ
 zuy+AAVi0uwrVMjCnxBHiLGWCpARxtbNJZUTepd4RyxynuU9pHPR+28Bk1t8H5LtVbf+wB+te
 TG/qTjYqGp1Rw9VWzMivdavYb5OX46EKdfiQVv2BaIvJxg/HTXxBMNobF08AI38yAdqJnWA3Z
 EmO2PRNo0IVSbcLLDB+lzQioAsUgewaQy/Ura4KZvdkR0N7L+CPLMIa3KtiMDw+yqvOHtJ9MB
 tsVEQa+EEto0yQzhZpfM0gkhLq0LZVIhnXKglNE7iPMKdJYh+qCA3dtvO5FCg3davfSSluItD
 RQcgEZaKqC8JIg0C6FIcZooNqQrJa26GrWG0p6Ml+5M/yMq9ihuSop/JyJ1zl38LiX0Tee23l
 PVoUtE3hwRp9aG6FGB31QVtKBuNEAC0aQAQI/o0dL07EwNm2C8b421YWq+zKp3MsIRbQkil8q
 heDK/jDvsEA35f3p+EsJg92T4EyqFgeKOaaqgTW1O51RlfU0zMMY6aK1bZ8JgVzM8jDEYxrl5
 f9rYTzf10JKiZhLXAQ7AX3Pzqtw1UhXKf6PMF4Os5NxRmgYXGnSd53NflXk9TUloMvLpACd67
 OYgnD/P0k5bsyAETO1nXc5NXKoYjv5bzG73BR/PK8uUq1K5iYdBHzlgkXKfdaZ/no3z5PgemQ
 SUdLuG/igWPGsN8WowXK37/ohircCY7bxgn94f1oEdYRPnA2IDdA2fRZRlECRa6Gq2qWD/51Q
 zbpLnUIc5S0SNXc06ub7BK3i7VV++kkzBPocLaTFVioqq/3jb/i5ebJxJKACLy96VUL3SbRtu
 0HsLOXUnxTj7rurgV7bOPdXq/MtcIofYXPTy0EZZWWuSIPxyN8N0qcwT2X5iu10RWeXEeOhgE
 xOIzmZTS82FOisgGvfTZFJS74A5EJ9A6ZPnkNHBshrhohuE1lYsMT4cnwEwKlaThF46NuCcgq
 Kex4/qiAi4jsfVSZ8JnZKDxBaDjQJ0R2Xgg9DBWmxB0qprnj93NX3j3vEThCmXccvsTMTO7gi
 YGdqsKFG2r0my3ZktHQUL+VbGs5xqhMz5HfGSY1EyS64FiGCJaPlJqjlitWIW7TO4TCfECmPW
 k470rM13aMG+g/Q4NDPhHx5l7XEw2zO68eLQIdw6/pmH61j+AQN2DyvpaV7hBtTaZeCjq/bxw
 sM9/rZW9equzo7qvcj+5vCJn3nFqNHp75r8zmxBr7PN0+0H6QgbTKAyHTIq8PC0RX5PwhkRBX
 OpMNzAtP4cQa/k+85XIpXqRWmNpXYf5mVXFPmzMof+h2H5at1lfhNI+UiNbg/Es3anFz1umeB
 8FbFQdCt09Ne4AULtEFdbuTjRO/0zbuSuLF93iTdGEOQ/53BIWTmbSpjlksrRoFBv3QqLfy7W
 Ws01xjtcPAqgl/sqyQXvnED9snGQ3e/zzw6HVn3PHQH2z46Gf/tMhv7tbxJrp1/5T3yFaqAI/
 jmh21b9VLTQT0nYcVAVqMO9bXGRtyowmCXTEVNrFxNq/hqQNTs5vFXp0FZtBsuESF5xvbbdID
 MQ2mJZxWz6ffEutC71v8hsXldxnSmQxkwJy98dmjPq5tUMXELOYFAR79NE0X2hrg0NCfaxPfO
 hhsM0CVrkIHhpx5l7YevgiqEy6FnWAGw+I9lKacyB5HhDFx17Z1ZwWAH2OUAl16fb3/s/kPO0
 DIeH/btbEbIjufp4FtlGi/9KvEDxqcw8Qg8P0pJrlnjC2g8I7bR8lyWNoPeneZlbscolKOyRa
 5sp8bX2CWZgdCAOgbg6Rv5vzNsSmBEP63BScba09KKCG7z2oXu1lJX0PH7Rd2cayTMszH/vdo
 hIjWTDdsa2MSNia3R/VUVij7/CE9WkXDeP5vck1xZpZKZ/Y004qmOClTN/nLGt0smmJAXyAG2
 8xgTibdRFIrWc7fJZrm/DgenEvXq5LYk2pyInxb2nIMCvpb5LwB4TfRoHhDWhoeEyBqESqAPy
 K79UxSRtLym79XmdWvDtjwExugbGWvawOVMZB5wSbS5nDJQ9DtV0LBX51AUw2E4gEcTMo506c
 Ene5zEXB8OA7tkyEtrawbMJRGYhv46UjYa7SbMDp0qfRmY0wAPFIXX6nuS5AK0K5lIO573oKy
 PQlssy+2f1LaMFL0RzEvpe1f0EIr9VakV/Gvw2xdwKhu417RjFP6qBdIxquCtxKSSgtzwsBfq
 5ugkVR6Up9WDrotpSNGAU6VKFzaKNs1t3D8lq6Zfe+1VATB4N4h4AMEIPHYj28/rHnH5FFEb7
 0n+NFYkXx2ejcWGYzDzKD+

Am 12.09.26 um 15:34 schrieb Rafael J. Wysocki (Intel):

> On Fri, Sep 11, 2026 at 11:35=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wro=
te:
>> Am 11.09.26 um 15:00 schrieb Rafael J. Wysocki:
>>
>>> Hi All,
>>>
>>> This series generally changes the way in which thermal class cooling d=
evices
>>> are used by ACPI device drivers registering them (ACPI processor, ACPI=
 fan,
>>> and ACPI video) and by the ACPI thermal zone device driver.
>>>
>>> First, it causes the thermal class cooling devices to be registered un=
der
>>> parents in specific locations within the device hierarchy which allows
>>> their relationships with other devices to be recognized more easily.  =
It
>>> also drops custom sysfs attributes registered by the users of the ther=
mal
>>> class cooling devices because they are not particularly useful any mor=
e
>>> when those devices get proper parents.
>>>
>>> Second, it modifies the ACPI thermal zone device driver to use thermal=
 class
>>> cooling device parent information for binding cooling devices to trip =
points
>>> in thermal zones, which was previously done with the help of the devda=
ta
>>> pointers of the cooling devices and effectively prevented drivers from=
 using
>>> the devdata pointers for their own purposes as originally intended.
>>>
>>> Finally, it updates the ACPI processor and ACPI fan drivers to use the
>>> devdata pointers of thermal class cooling devices in a bit more effici=
ent
>>> way.
>>>
>>> The first two patches in the series are preliminary fixes preventing
>>> Sashiko from reporting "pre-existing issues" in the subsequent patches=
.
>>>
>>> The third patch is a thermal core update allowing thermal class coolin=
g
>>> devices to be registered under proper parents.
>>>
>>> The other patches update the ACPI processor, ACPI video, and ACPI fan
>>> drivers as per the above.
>>>
>>> The details are covered by individual patch changelogs.
>>>
>>> Thanks!
>> Nice patch series, it looks mostly good to me.
> Thanks!
>
>> Do you plan something similar for thermal zones?
> I do overall, but that is a bit harder due to the hwmon involvement.

I understand, maybe we can discuss this on the LPC.

Thanks,
Armin Wolf

