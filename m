Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794269986;
	b=jo4YXmUDdxVdFwiLdqJOPHhXw0Kx5dYsyrzzHyfACwObRbSoWYw28c0bikqt3RoOLWP8
	 3i9lHJp4tHzUtjuXNFKJCnvGsB6wG3HxL+AfRbTSzdj3MTxqMeMLFTyDh+xF4es94dH5o
	 SV6TLWNWc+QWg41dw9b+jeuM9Tle4AglGBgcYHQ8iAer55A5l5ye7Dk5lEklRMa7PBSrK
	 m7Zl9ROss2pjGL4ghtqNlxBwbwN6lgLSIAc3iTKNFHQMdezJVW/S4mGH053YZPmoVtE8e
	 ceZ+Fefuv0OW/AsK/m2d+eDr22zjUxqYj/ZP1j9UACCBYL7jAaRHW3+x8BrZpFUO4KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794269986;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=/RER00NDr9Q6NVXXkd7Gp6Tg8Wv+6goEFJNK2IeOJR0=;
	b=ZqdeSM98vMzar87gjsou5bJHbHp126OarhMBfQcY4hN6U9Vnk/er3HbwZ4tpZBIoVjZw
	 pN9dspxbCy4cnbQDRdtaNfrURQHRnt2oGC/PcvKg9QrXe9gnJjhV1zy5aiXDibEh/o4dj
	 +pJwcUadKOrZX2U/J7tRkiQlI076K+Wf2hftPVr8I/ZS+5LeWqtDxkzgntDqozSix5Z6u
	 4jIOzPhtgYFK0J9mc/u+MHtCLjr3l1wkPRKHekpl5O23K3P8/bWBvXLycGCjuomuDViTO
	 nvHFn3pKpE0iwRGWdn9g1RMYrJgAEZZ8BfxnwKb02id0doxkmygFyugKYgJrqrUBz0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=lvq2n7Ji;
	arc=none smtp.remote-ip=212.227.15.19
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E673606A321;
	Tue, 10 Nov 2026 00:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E673606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=lvq2n7Ji
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794269983; x=1794874783; i=w_armin@gmx.de;
	bh=/RER00NDr9Q6NVXXkd7Gp6Tg8Wv+6goEFJNK2IeOJR0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lvq2n7JiPBGqt9WlZSlN1n1Rjnyo3h6j+HqTIJ1xY70tzRUH4uWmhj0YAs5jBj5x
	 E9WPrywA2vgeI5XEq/+DSiDyJbMIU0CEpjX4HYrjuQHi0cKW6hOCWYY86iZnRTSkN
	 b18EPHOTMO0jXf50vk0QdmPzpU0YpvknS9xoCdbXmydAxLqOi6i1vUHldn0Kv/cAJ
	 EDNPbjg79f5Ei4/TqCweWAmekeT+svJBGLoWfW9eWNvaDyLM0K0Cjsc5n7g9Qn/Fe
	 uv9ScxrkaquyHf4DmjahkYcwVfVMdxKlA8NwBlH1K2o5J4+z+RCXrEJNs1BfNJFiY
	 FaiTHDvaWhbKM4U4JA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2f5Z-1xTbii17Wx-00DSUx; Tue, 10
 Nov 2026 01:19:43 +0100
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
Subject: [PATCH 2/9] power: supply: Enable struct power_supply_ext to be construct dynamically
Date: Tue, 10 Nov 2026 01:06:44 +0100
Message-ID: <20261110001725.851443-3-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:JHPDA8x80FPajvTz3ELJ8/BXpExR95iq+jkh9gwSHoL7Y084tDp
 BEJ253iNRFxkuM0zakmdIpAmEFo+neQ8G07V06+eiL5g2E+xCJdt63Auq/AIw1odnN07+XP
 XOKiG53EIqY5bjbRLfSYjHGV+RpB3TqygUs1FDIpBxF7ja6cXvzXqYXOIn4x5/abXfzgK+i
 /U0AGBIAzgRN+4GpZvEQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gT+ZrI+gdmY=;CeAoiT+JXqZo7Q11vMYYWIUWLc1
 TExxEnJzSnYq3jIz071VW3phfZza72nw44d21skUthJajzKiYXF+TMGhH3BXqOrQ2qjJdZALw
 YwvWLogqOiT7QDENlhJkz/YalZ5fEwEcF3lcDU/iwk1skkTVGUo7kC5eyeMVS62hvTpsuIHLJ
 RbqniTjmniWifEJXAnx5PfrFk+DEg1vnWyieeomQSEiHCVDc5Xn8yB4ovZAmYXW6x2Dvo8wWB
 ps7P21qsgsGNL+zI8/f4trRbInayO+Vo9x0BVIzlPZUoR5JT4x0vlQELIOQtMF2f2yisgkizd
 7QNM6j9HP+0FL7NO4dUsEQ3tumP+JEZuFxFs1mIMgLY3KBmp7RLh0a00oOBZV9g84uDuYWpvJ
 yzI6DEAtlVrmRXaKqylN/7/8kfbfpgdP3cc8vXaMsK1xjiCPI1qhwD3I9cTgdsT165qKnpZnv
 4eRnfUczilmj+e0EwgPiI2n0Z4O7eCTlYXDYR6lifssMRvXal+5kD0Y3V7pp86tDCyTBWnkrq
 jLfHdT7V9OHJs5FaiQfSPy1n3DjvO0+SK1s1wCJjWS6MAYXQS7UF7xwHKarZrPNFn3kL+OOX1
 q1LGMX+hQ2XEDEPCiE7YJlf5repXvN1CEHVwQkudijmCryWuFyHXcMnnXl2v1H+NO1GCCwRcR
 h8brUTY4tl5Jr7kgdwf9Xsinbz11ceMthJzeDwSEfEpvaUEbSAVkRWcGb6iUJtiJ6rXS2KRmP
 O3FKFM2dNefX59fC2+/eO1uz93blZBKQ0EQ8bITZQIE0GquIxoW5udMbp5u1JosnicyZNYajJ
 Nk0lKzckdTLf6QQk+vCgbx3lKiaWK79hcOn/fjZ8V5+ydO8nbU4hXKCOadVAkckXD3dZEeiKD
 miTSj/IhbBb9pw1VYR9oOAxbBnYXewyc/1z6cUBHB6d2pfZXrKQmwDxxDAjwn9QJd4vAqbBD5
 lB/Rjk8sk+zj52B+j019VVGK1ShK6iJZOk+0nukuBMhx4L/LJ4gXnpE5KUvI3IImgpub6S0EK
 dUKCFnMAAVmyMudjBBjCM749A9BQ0x6XsxIvuHF/MmvKXGdgozAmX85R9W2hKR8gZqRYgPlP2
 WFSI00ArdscqBLAmJp++rDW4jfcImb5eO5pS3YNjGmQgGnet6XLkSpd8Y/yjdYNOUkFTZ7lz3
 I46lqx7NMp93Ce4tAK/LWA/xd4Cu9KAuHfQyAfTRU374vrnmw+ZSzhtNNJYJKJAL0e+GerD/7
 PMe3zVi5NXj7u5nGTOARo883+Le50nZYmGs3NaUEnU4SWTJNGz0phVFgRrU8ghYPfugjATzJR
 lZ4lirqX2Y/DXAfBCx6xhDr3MQfBUdJYS+DNzfgUFhjpnzg4jhBJpbF0ecvGnFzhRA+SwuGCz
 7JrEnPZ7s9iTTH3zC9fH0nBZk8BkkTcB8uL+tJRSC697zch21kmCNMxCbsRnv1PLLaubzAF4y
 OD+EjTUQTq+DnEp9b738DsFwqqr7rHTYQI4Qm3oSQWkOz6wUSvWr9Hqc0JqUM+9+zUl0Macim
 GbKj0fq1/o0yZMgsCxxp+MGrRf1E5ikFbCg2WKpiNNClW6aNShTHw62hqM2a8m3b6jAG6oJfQ
 mrMuLaGuLwaBqettf/+dygxQkdJ6luOoWm2iwdtY9+y1eoTpkWzZiKiEo9OgbxOMxMeE7p3Cl
 uaA8FnDGUcw4fZ04W7PF9e2NTns8x1kSn9nOJXEwGSeRzJ3NzhmDuGUDqL8+Xk+lfh/6d0j3W
 eyiLXp05RX7CIRWuGlUggEZKkgyihC/sSHjlCZLu1tgvzaZOfUPV/BMnw1+g5Cp1I6KhMoY7U
 PFf8SpniX/dy8hmhUy5s7jCGieWZ78n7YRhYk9cXN18rgKb4H3UjIUr9Q/Ml3g9tq0uRtO9D7
 ODPMyrM9CY1ZqkLgriUoOpdFmkggL/5WBcdk27QWQlfQsqJ8hfjmIWk2bDDmPoE0DPv0XFMvQ
 glEZ1HuZKsYQFZw20qbwwYaR8DQslrE3k1DaXq5lxF7MI1D+ughIE5yUWHSJcAbAEyYQwcGvR
 SlKcfcfTfWFEjzOC7iTcmFIpcFawZ9iSS4B7zmfpn9a+vlxHQR2hIe7fSPjtrzqam49Eul4xX
 v5Vo+P1nViTNkSqjb1+UgX4FHUpdk9ZoSJsvE83/RpoZdoBjxzdSrS9erKNri7TQCI7UkNPGY
 MjkJTP6t+TXvvOsAligoB/ijUQWFptkmxMBMTafTN1740SG0Lozr7v5qaVf3bgIXTgSVE/B9g
 0cGowFJJuJ1hBNJ1zz9j+xutQDBgtX8a0sITiqVUdwhiIlVHPqrtWDsDo2sJsjAF94V49a6z/
 8Z+nb+8sk8TGkgjxAg69VpGHDXlm/K+8OnADgIZFu56IteHyLFeigOVtWzC07sFgQBGUJFgTA
 5+PYrnkDLI5JNKKBxRgA2DiB+KBipqY5uHgveMf2pd5aViHU874/onRmUJb7snQ2C5lmBbe29
 m8yNlnwi6G8WPXUMh5Z1OHhM8xeZ22JhrtKh2XjC/MWmuyWgcCUnP6CyaXt833da9RxnOcOOF
 Kzfxxq2CjMJGrUuVwOJ/8wpi+a2w4aL69bHf7Bf385g0Qp1gOHUbGIt5TuBRhyu4a0YStqbYR
 6DvGWJvIcOhmi2lYtdVgFpsHPzZii28m+BTjRKONz6qBDfPD5fURGyUFRK1Yfn+HmTLtSkSLf
 6QMXHXHf0ZOHP9Q9xxtXoUKP31A3MpgT9FmI9Mu1fGcSNBsxSQd7IJnXeih5k5lnNacUYqbzG
 TtBlzvRmIpKqSiCtOSTStfI+xVKQaCfRuu7ahTKBIYlrvZun/eKa3Einkz+0QqB+Xcns5KK05
 HF577zB+Z50twSIz+yixz+netLXkMx1wrkx5v13rwPgWaj20uAvcrNMABslmCDaLw+QQQfV0i
 ZV6/N66liNLQe1CtukXMBaghZDjtl7Zu5dycZpK+eCZ/85//PAcVByXfCDgb0+RppP1y0755P
 3XifIRU7TdEBumyg5eexHEKQ6WwSr1c+1RYgs8bLteeXw3qDHtrWXJropzygThxPFEEwgemEJ
 f8cNeravbkG82X/CZ4eGydDhmQ/gyv4p+O43eNeHpzro0x/xaQYwJDbKZ4GwhcrBTcSedXEeJ
 rEPZFAy6uEZO66TLivSXf8OhQskEQpvRbAavfmanIydZvkGYlsCnMOpIJRu//f2YRRkX1WG62
 32WHVq/TkCctZtB4wTw4E97CKYMBhwObvpHBh7JKbVsmfl+9HL8J0zJ3FVNkCdiE9Ws5pN7XN
 Q9+n+pZuQUfjkby1wXh7+RebUGZuNnpaGx3Fw2o14xSRJkL7pNsArpkVWkoJAQ4O42WptCgof
 swwXCdaEmFR8xMRlZMYsE2KRXM0uM89vQCLFs6iuvh5UiLidzYvm/pPh1Tzc0gANExISNhSE9
 XSOzzooMXdb6+jQJYzpWAXKdBGk4Gxvoza0QFscIrqWZ0cThkTx6Z0HXqjgphPDbpFLQsvG1M
 J7agKRmKvr3ICsv08ClOf2xtukxcvo020aUyCNbL7sctLF6iEzB5L4LH5TyuaLE/3x4DIf0C7
 5cK8Yh8PHhLq+fFGA9yMgRuSwMq+vQymCTn6GqBfBxNRGwnZARvpvGE6h7vQ/x8eVNh/eUBh9
 OBL/3bFgRwD945cFZMrqEwoLE8SsafdhDENksWKbs5RL5Kfvm6H3AlfB4e2p1RdIKTUjMtg+D
 Vj+whQ+qfTrCW1gBhsk6wHsJ7Rj/hqSAmA3p6KgHifZUHsSNWzr+rWxE+V4cZT6YSzEDfYbQ0
 OSk/DwuVmvencBX7Re9TcXgUupON/M8T6lRk6W2w1tyqP4FFlwVRT+szqtfmnWeEV7TVAXUfN
 qJkRnARpMz5/mqANxg7zF94MR7WEkzsfotwpE7fWqWTevPC7Z6OFekZD1IZtgtfDf9QrRl7An
 czulZKMiPnlIufHRO7p/YftwNOcQHwscWz4EejuX3cfHSLTPWCTrAo2GNQwsbtYegFAD6aoUu
 r+kE0Z9kgMRul0FXSCJ51O5CfbYf0xm63RFEFKLBpzp3EWgEqigNRTH8Q5yfC6I4XqJLjcU3E
 nsgD/2SJ1JYCBP1V7xe12KmaKoPnKQcFttFIDz0qACEAXiJiux6KCR2JOU8TXjwDFWXjh7IJZ
 QqA2O+q48AdsVAs/p/xCsaeFFQtf1R/3raNc8r8WNwcyLIW8C9O3B1UrekROZj+NIwJ+1lM0b
 +i0LmnmtMOm5mkV1KqmJs/IseoB5r2BxzI8E1yal7Btsip7CxKcWzBYKQq7M8YC5SOB3k4iAE
 aHwtjun4zvm/SFVJqfPqtuDqs6BxawDgpYcfA9lA13Jhy/ksGxcyDnowdnjD/iPAi/pSm0Lc9
 undh+NRnfi9zpFLJOoS51oxaIZZ8LP7vqzIx3Monnr7tmBgtd/6yCYGQpPXS7sPdGZD/liss1
 Rqc6mnUcQ0s9sIXd6B1Kic/oXQDewcrie7C5kHk9lk7B8ns8AeDkSVMSd4Eh8X+jaPYZr4TM2
 3q3n9ni37y5gWYTso++cGtHb8/k1mCJu/Smr0nUYudkrxmWDHxfEUzffs94cuvV58fPECAL0B
 Ed3gxnYpt3J3YBao8Pa8SeUuMoU/19M1/mAh1cse1MVic3lnjMxWT3x2dbMUS/jLqnHvX1r8f
 daVOvWRwTbC8k+XhmqPAO5uU7FsjDF9lUmNGRbcYHJuoe7AdKBlDcbbsc6qfsvp2fA5q/jP4+
 AoBrcDAJK72btT7maqfobgjX4/j7n8QU16/4GHI8sqAvPGCp15E2eeXdz49vvnF0c5uWEipkB
 w5e87nEEPwymtgp1JkAafPtAbokhpJxOghNVC8xkwTOaLH+G19fC8FzcXPztv4CSrvo9/QBMO
 CmbGoO84MCzSWuz2156chN6GkuNh/XQv5bFosg8WjhvYOLQpxgqZaidAXClmpFTFjkSLkT5M6
 9oszR+pqBS+MwuFFKhR45M7d1paaRgIGMlVC/s7nVaMPekDQKxFjnWVJL1U7LvOGlhj3MyQHT
 ++V0+USphf8QZsevriFUtqZziRCYoFg9pDbvk85UNWYlKXLIlbk+OS8pDLYes3gu+k0z0xwQD
 mtzpGqlmDtlXgRtB4A7YNF9kvFadaUKTqzd2v4s5dS4h5F/bJms/YLgLfyIVHo/8pZT4Ozg0u
 MfRKI/LBT9Z+7bPsQlcZ+thOLk0eGJkl1FIHsFfyr5hQSX3rPW7lnPXq9JLPudbVjtr17SosZ
 4wVr+k0BAjVJ01BSjVlmkFaj6TpDBXdg1zarvUxtUkU/fM+svSrrbbEDq99jKEQntGYhwQosV
 l171Z9IZbPet47sElgEDqZ80QMh166OIcHein8eyiP+gsv5V4SCcrGXeVK3lZh6RN3NgwYlE9
 +UA5tRG/896CWv09A5/T7vKYya71GsfkVYolE9ccnHGRJ/Y1BSJL5h7M/HpsdW4rum+e+vFun
 KHVzra3xKgEujexy54rylchaD3qk88xCKKC4fa7hub8DknrvOsOF2Ai+/DDVxYNT8sRKgGirP
 Q3C7gUT4rPVuWL26j6BPxb7hsSfLO5LUycVUumRyJr9lLefdq1mAaDqjGPShDtoz8AThyBNRI
 QwxTCyzuvZrqFS3aFWaxVDaEkI2K2SIsaWjGx7ep3amcz7sh6SGtJeum1Zajh2u/FGQULTFyE
 KgF87wvw59Kao4DB4T8XS9nwrtKe/K5GPq+2FhfWlA9B52ZhrQ+mDexiQZ3u+igEftb6L46pH
 UgJZrrO/nRGMclR9qzhT5Ogod3JWcMHzUzNkUOegxPuRS5jrmh3yTSHPEWXkGegTilzhL0BEb
 CJIL7o87mbzMAEUbkY+0VdoxCNM5PwMfNt0qm92QSsFRQHgfJnCXi27Ke3WKMSzV5JfIvqUfQ
 DBXpTDOYM1a3VErcO5LwuRVxQ2c9mxNqRiQXvvqTKE/Dcqa9pSFnxwjn5NAn+x+FRtoKn/4Vz
 SUISsqnqeheIz81smCBn946Fy6zUSYD4TVJCVYonqvsZQxvzxlj4aziQP0mMO/7VG0gTTjfsz
 tagDIV6YJ0uGckVVpMJ+VkzniJ5a0BiuGcsF2o8Mbbv908Ja1CirnXyc7tO546MO+5pbnM2x3
 w50vHaXMBThB83XHoNCeDbMBOLZmNt7yzPIeosC9qBWqbyEHTUqsUmpHnmQwKuNiTjPEXNkIv
 Jlbi2o9LEktsf1yHaXixxNgE+SPo/fpdTNp+pauGoqrzv4CrNydGC4BbBtcjknR2kVV+g63NQ
 xDK/MmjiVZeOM8VgzlDXWdtClRHK+kmGCuz9FOSX0EA0uJOAO91OVVdGyocobRFUiyLw6/TeV
 U/ucMN9iJcR8uLQwZzga8YznO3NgiIJjNpxNA3GsM+LW2hi1wGN9nyMdI4aWho8ukSL4XFeZv
 Ft0aj/I3R30VpgVHeS8ccNUSFc8+AcVPlyF3ttmiP2uQ6LifIym7eYxX4LuvhHZZoZNCumpWz
 zo/560X7kAtOqrTDex0RVHU4SLoLHcey1Ywo4QFR6QSJYiDP6akEPoJTzpp1yMe71ik7WcZKV
 pp89DLkKpuQNu836S7nI44wkoAjdh63jiqR2Lo9ojJ/FVO/NQsxUM9cNSTq08fhbJHt+Zg0Bf
 Zk7uZm1sQvSpitTnLDEYSU7GcBRHbJV2OJ6nNSmBPIgJtfvbpmZjC5l5Uj3RxjoN35RBGF01X
 p8Olx3WUtTOjwqOjOViD3jQjo5+HS6DeTlJXlTYedXQG8apq65FGimuupjWC7mUg+asItn+FN
 LFbdROdA1eapevkj+AAiPnuLXUoTNyMheJJtzeb6b26VXR3aEkrClwT/nlgl9UxI50ffcyyN0
 oJ+MIQNdPMu2xjfVV+q6k7geuuXVBb3IM0e2WNT1PK5stkl0Tu80VeLsLBqfXvQDfL7UXcOIn
 t2+pa4n20zyi7Wq2/NNM2sg4PCy9/tKyjBdC09jvmiU41XwQhZTHK74p8lQPp0QEkUqAPlUlv
 JMhpN5JoKfik7O/XhZUYUlzfcCUDoVDYIgxQP/d77FPJQGrdwYdpC8eG31vY+qfg7EA15iIxm
 +mRqbfCpqhbg1QOWJ/p678n6NToLH5LZKt6G+fdvNv3aQJgfp5LRV/cAqVsbN5inWLBjjjR9L
 258LvhqjH9csRKYNw3EUsTdE66jcCrpHK+cvRFbwzhnbkCPqCAIrdkQDGK73qwTGHbuh3AkVo
 mqv1QExdc2UZwzdGa4+uzWxGCUFAFEIuEp4g0pomhRaVxJtP8zalWW/xOChImHfr59CTLAbe4
 wyNWg4TDc6dSwaG53ymsfRCYV3fJGQbRfVVXs590luj670+TVnYb/rwv32ukPaV/H4ARdrVJA
 BjYk9DYeCOTuIQilzXTAvNdu0jKDTcnmn/RQchywj8s2Lx4uN2Zzu9Ru4SiPQnveSSiN4IWjZ
 PkuhHekK5yJrUUX

Providers of power supply extensions currently cannot construct them
dynamically because the pointer to the name string is declared as
being const, even when the remaining members of
struct power_supply_ext are not declared as being const.

Remove this pointless restriction to allow providers to dynamically
construct power supply extensions.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 include/linux/power_supply.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 73bcb127d0fc..a0cabc139298 100644
=2D-- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -318,7 +318,7 @@ struct power_supply_desc {
 };
=20
 struct power_supply_ext {
-	const char *const name;
+	const char *name;
 	u8 charge_behaviours;
 	u32 charge_types;
 	const enum power_supply_property *properties;
=2D-=20
2.56.0

