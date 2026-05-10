Received: from sonic311-31.consmr.mail.ir2.yahoo.com (sonic311-31.consmr.mail.ir2.yahoo.com [77.238.176.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290E330F55B
	for <linux-pm@vger.kernel.org>; Sun, 10 May 2026 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.176.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778426895; cv=none; b=P4tNjyNBbaQVbUwOuPPf6oqBW6TREk7WQkFkqz52caarex/GihCqUpbaQNauHAopgZE3sQwMaQGwCkT43wUqraB3zaZUM2LQsU7fWwFJPe/SLrUXPouwUn6hWlcPLv3Qke6O/NJHyQqJNzx115Ts6Vj6crtioUsdUXMoQbPgRaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778426895; c=relaxed/simple;
	bh=k4vrdSdqTYKtlpA2IBcDPZn6DPODy3ZPA/tWBDDOKsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=pQymK63GXuHA/ogXSQp2D++tTNMvzRwSSDu1X29dhVsGGTrWabnMGRGjRRfqP1qlyVMAqnoGapEjbT8aPJ/GR8ovU9i/J0+rSdT0qt2WNF2cSHrhEVYJ0k+2l9bAnxtjEVXi0N+DPsULRIEgfg8bBnLRdt7bEIGdPJoxleon6sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=T6gpSFhi; arc=none smtp.client-ip=77.238.176.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="T6gpSFhi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778426892; bh=yhzNK1MxXhWyKER6B16J+oTKxIWa+vvZ+vg1sOhzKfc=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=T6gpSFhiUSkh/li8UsQ6f6WOYtsU7ea/FbC0RrVOHW0AwxY826GptzdjJvkw9RW7STtibWL8Rarc2/ZoxsqxfZqEPN5XluVbJyyuJbDCYUu1ukWD4xnsIcwAO2AFhYfhZWotHaARy7urqjxMLwwfM1Gxpl/FiPVM+ZOKWNwaKYNHgUjqRuHj/KM+EVDDkMkSEJ8piBzzlhi2pEPfBCjcV2wJbRIU+YypffY47ldnxfgz4z+DsLsGTXBY6sojajLyvrCzICcty+CYyFiPTQVA8U63Li0OYLmsr91cumdVp3926YkCS1KnZfIVjzqrLthTy1qhgEpjhChvBPMMYIZOfQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778426892; bh=9zsjJAA9irII3i8PLQQTsZR6wJHg2ZxsBgLqmRFYVS7=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=fM5hGbsAyOTougSH0p1pm9Tif81cgTgtRepUy5M51qeioeP4rFMsx/YnMVV5c02H9t/tJUrkyWHlbBCUpqJ1Yy9eW8+M+AQl9vZGpWEICx87X33jYAbHct5qOsGbM9Y1Rq+gBriTka/gXb0yUv7KmIq/9lW5cc+fsW9cHG1g7joH879IDBREXxC9zXrsT402K9jkOeXRmw14vOMqEd8ImZ6NqTnSK9Yq5HwpNrOD8yafKuIc+20sZYlSTTb9Ef/+t2wXXl2ezA//B0AJpTVVBwY76sOHJWLa0R7nX5ySshdx4NoabZIs+xtUJkdbJG2rDyqpRNTuDl0c9TehoEDf9A==
X-YMail-OSG: LlHhvqEVM1lNCZ.JIjqOcpjJTUU04M6yKmfO34BA7SBoIjFfDrNQB65qDBeum70
 BbD.NcuEZi0xCHWZt9bkYFwfrYPfJRTiCWnXx78rL.nMskrfaDY7ri3lT560GB5CV8FDmzLIele9
 ta_yB2GN3Enwy7YPvDVQWqCGESoJHaA4diwL305SJ.GOqV1XGCoi7quZvI6UD0PNWlrPd.U4JG8c
 1lxdM35gd3Vfdi_nABvrqZh3OdSJRHQbe_FPXDZejzYfIB0gCN5Hfaahy7deY_RcvX3uc8O6btm9
 k0mx65QZW7cZUouqCplU11zx_rM79MXF3jGFmarmKsrhtH5RqcW9xEtdaxnjObLRiWInBYlFVuHF
 d6LbzqhBfKYzz9uwr.wiBIUq2c.lPcXLB59uv08eNe4cJp55aLu0rzQbhvsacdtBIb7OGVxlkM1D
 Rwz0KlTFV.FoixyN2KnphB1giN444rteBvm4oFZLy164r0XrC3OJttfi_XhxNzPucANPOtudzZEQ
 HdYXQTu0pClmjxkH2OJBUwLlSRzrq1KmrZQJldu8Z2CzovMGJyDSWcj4e9Tuag_KeFyrHKaEHH5V
 XHKey71F1rq6.dWy1gbp7Wsksd1NE.4cprkz7inlM8B6Ge1xuxgxEd62wjvULmvi2eKmGOPTrH0.
 KT5MrH1pcjRB7NGTzseOFuA6Gma86C.U2ALDiffFeZCBqf6hbGDJQyro8MrvgCCBaTsiR.uUl80n
 8H6zRNwtTYLbsbiERnWMcJ5MWlypMC6duSx5LadLmp53kiaX5CnZjJnPd_s_c5fMWnd6_hrSP39x
 rVR.9zTAqIa4PnrjPNcx_FQUaw.38goJsBMU9n.pVvp0XxFD4kRW9fG0nPpMDk9zvveow0rnuu6L
 9IyM045Rmsa_6G9MYhc8ayy9I8l8JbZw3bb3yVjhUbGLIk3S72yFcYsjzaBjk51awote69HpBOQT
 CwmxFf2AZFSFPVHW3wXkjs7WaA1Yho3E5ooOc6dNeZSICpMd9iOdc2Ev8QHHwE7Odqoh9dU4RH7q
 Q51NblRVzTIq.qcHOCywrUFWnOG6hezFouJ2PhI7U6SVksOPP9fhvCrUrjxRpB9qdgZ4AK39XohV
 vV99mLI5Ywx5NgouiqQVZ.yB_S7i8oaa1ir1CiL8Qx8U7S3_t_rabDJCYZR3On2CTY6vM8.Iqn2P
 88bRtAtXGWU3ouIURMBvdW2KSuwXJ_w_OP2x8sXZaUaBdgm.lmxq_TsJExRJzVEdrFfig6PV20I1
 m3klIAJkPhKckzJ1QrGyuNRjKWluB4aE9voqoa0OOYvM0tXVkF1DhJBk_p9ftKtLePayfqw1SwD3
 B8_PGZVZ8Kw2WviwjR1vbu5xK3aEr.RvDe1NVbzeco5TA4q8HiDxYMik3XUiyn_H7H1xUIYrdqmJ
 RqV_KNKwsuaBuxqTgKxgqmkqjoLUGS7mnAJkgfzCtqg0IfDMAVX6RjpbTbEDSOREF1hQ.eZEd8lz
 HvUawYTg7wrFVCNtMrfPR7OwUu74Twm.IFAPG9FvG7TFHx4XpleDJ4OGkBb42rqrm9Y_HNvntWhR
 LcTKPChEB.tphGVoeUQQkOTvnqDP7VOR7DR5CC._h13zUUNXKqkgMIt6ovftmRaaaekEXh1zHNdl
 Ez44Eu.teK9JLGUtYvtsFWuzcNg14TICXNux0tJdJq3uTzNbmjvlNZNUlexUCD.aAQ61_d33nXNV
 _NMuofGj5XdZq3UJwNsyEzEz.bnqL_R.d3bF0Ga0IlPb0NkGutoKIdxbieEoPxjdaB5og7RU4rGw
 x2tSMRYTmfOGYam_tYZLQZY0PaIx8nSrtkcvyfzvHyKoW3RzpHOQqyno5VgMJu3TOjXtTOvuVnrE
 3PugZl0ACuJ2yA1FjlhWJio9uA5N9fedSEbpnVJTTEdQU2tcWJO5bImu7R2uO9amyNAJzs_pncb0
 6rQBFg2A_yO1M_EZi5lt.eqKjGn2Vx8f0Jy.dSbkCJ1vyW1uu.ZPhmUaer2yBOmPw59twdtli3Sc
 IB4zCe_g9PRFcoduIiqaXGLEBnt2yJzGkeXMNxNtAOD_tlY0ZLjJaHCJan6aql6VvY4w_t3e.rPu
 XuGqrLWSMMpmD7QRomEmQRbBIjIjGOPBl_aASNzvvrxJGCGH9ZS9XH_zmtnL_QAdFsVn10fE4oLo
 TKAH1yPuVgp9Ed6676Sh4I4l6bPtTpvgfX525RarQT9liorj43Ar_3GNGVkJVath0.rqWDIJ_GFQ
 fjZSo55fPaL7YEluV4Q4HIVlP1aTXZcIoaKw3VO4YCr2D8N5PPfdSU1dQXxk-
X-Sonic-MF: <nicobsc4@yahoo.com>
X-Sonic-ID: 8edaed84-9363-45fc-8b94-d1167729b603
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ir2.yahoo.com with HTTP; Sun, 10 May 2026 15:28:12 +0000
Received: by hermes--production-ir2-89844b765-82cnf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ce718115184f3a1163bd756cced3f7a1;
          Sun, 10 May 2026 14:33:20 +0000 (UTC)
From: NicoErdmann <nicobsc4@yahoo.com>
To: linux-pm@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	NicoErdmann <nicobsc4@yahoo.com>
Subject: [PATCH] cpufreq-stats: document limitations on modern cpufreq drivers
Date: Sun, 10 May 2026 16:33:03 +0200
Message-ID: <20260510143303.120863-1-nicobsc4@yahoo.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260510143303.120863-1-nicobsc4.ref@yahoo.com>

Signed-off-by: NicoErdmann <nicobsc4@yahoo.com>
---
 Documentation/cpu-freq/cpufreq-stats.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/cpu-freq/cpufreq-stats.rst b/Documentation/cpu-freq/cpufreq-stats.rst
index 9ad695b1c7db..e8a8b3a85ad8 100644
--- a/Documentation/cpu-freq/cpufreq-stats.rst
+++ b/Documentation/cpu-freq/cpufreq-stats.rst
@@ -28,6 +28,13 @@ Various statistics will form read_only files under this directory.
 This driver is designed to be independent of any particular cpufreq_driver
 that may be running on your CPU. So, it will work with any cpufreq_driver.
 
+.. note::
+	
+   On some modern systems, this interface may not be available or may not
+   expose meaningful statistics depending on the active CPU frequency scaling driver.
+
+   In particular, drivers such as intel_pstate or amd_pstate may use alternative
+   mechanisms for frequency scaling and accounting
 
 2. Statistics Provided (with example)
 =====================================
-- 
2.54.0

