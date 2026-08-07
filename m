Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C73A3AAF67;
	Fri,  7 Aug 2026 02:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786068017; cv=none; b=HkdAX/vGFOwt97d9LeiOdssb2pCb3SioDphQzi1+TuTDFjK8YM0DdWMWFJp+o7lR5ZFm6QfmEO0g4oPUj1WPJ0x+etLgNkYFvXZazsgG+6xIZqad+LDOVLHCY2HkQlabvrg0lFgwdl3657AktUYkDixixsDELK0tQ8lqzfyEDx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786068017; c=relaxed/simple;
	bh=luT17W6JwPNzDTantNzwihRXEtF33jeNTIpj44YmkoI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bD/sh0M54efrfJkRLqbPQzPhJalLR5xNaEvLFogM5MaPvq7tC+ctJrjPu6fMsNhbl1tmthKyIJLAVWEpSrG716QG3wwpzvJ8GDFHkHhgzgwQiTe9lNr7IYJmQKIkb3DfUD5+XvsSpZ0qdSPbOEOSReGoCA+Xkl1oPgVbhrValLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=BkdW5MCO; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="BkdW5MCO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1786067996;
	bh=4jWCOeKhzKyQSZGatSWRuKZpqMiP/H/phhuCeUn8LfQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=BkdW5MCO724CHQwdHafvNqfcdntB95QbLAmi+8TXGs+d3/z/HLrJX9Dm0VJTxRr3Y
	 7X2UBEwV4WxA0E0PbxPZKUZ+O16au+P8JKbqgEKPYHB8P7r6erslPw/v+RmSo/Iyf9
	 WgpFDNHatLpDAPOoX0WxWoUSlpwqRz2npSBdz4Vg=
X-QQ-mid: zesmtpsz1t1786067991t016aaab1
X-QQ-Originating-IP: gWtj205Dnnn3MeD16Qvc94piaBh9wxJLKisfZk8ybQk=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 07 Aug 2026 09:59:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3257373749632848062
EX-QQ-RecipientCnt: 13
From: Yichong Chen <chenyichong@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: chenyichong@uniontech.com,
	dakr@kernel.org,
	djakov@kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	quic_mdtipton@quicinc.com,
	rafael@kernel.org,
	vkoul@kernel.org,
	yung-chuan.liao@linux.intel.com
Subject: Re: [PATCH v2 1/3] interconnect: debugfs: replace writable string helper
Date: Fri,  7 Aug 2026 09:59:30 +0800
Message-Id: <20260807015930.1067612-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <2026080632-delighted-bonsai-18b7@gregkh>
References: <2026080632-delighted-bonsai-18b7@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MiGKX+GVf9O3sVrzY5Xj3pkFPz3hjAc0X/MSX0ideJpSkesevtn72Vf8
	BZaP0xPDpIDrRsHUqQlS8iiDECAdxao7eVGrrdn0nl6/2wUcp27C65csUZznVR9CyDn6eBe
	sKkf5D2iVjoE8oC/5L9hBjCTWrH8o6ToYzJJa655o5GwjLZFYF82KxCB7Ym901kuzadmPRP
	/1CzPFTL/J6FbCoq7PjXuCbdPDGitzk1ezDWTqcEGsISpAtMKuTslwsIR3RPC39VmeFrCZm
	4so0KrRNUPzxH6Rf02Mc0KzEcZDEVWmtP/hBxbe6CCg3crjSArSzQG+TpfTCmOden2blE9E
	kprOQt9E83m/H6WpbUDk/4nZhK3DlKWD5auec9wK3r0Feg0FRLLWqNIw26vMh8Q1c5dVAHU
	jygqnDi5jbZDC4JwM6kNI1eXehT92oUZ4oJQ1W9hwJRRGZchjYmBDAS3iEDtuBMhxgoiFGb
	YgUukcD+V5tpeF9PRAi6glV7Zp5ACV7F2BrKu6C/jwR2s89vcCTs7SW/vY2yupX39ou+Mjb
	Ylcm2VYz1bvIsqY8tnN0S1LfTqlgh7clOFxP8rlYcCCOp27LHF5vN58yaOMhaov9bZbgVxQ
	kg+8ZLysat2yJ58nmihOa8VSLqgxo580QZhwKBRzNnUFdXIQBOPIUdXmKNFErGBFVM3uDFa
	vQWiYRvqTdqnJQhFzwfTB9wTpOmOtsg04XKUYTSshmwwHJDgGyBBwviSaDxvCl61ShTG6uw
	0Z4pOoDMtgP/OD4wfCfycFabsTCHV2LcXINOYEuFOs3Tx+9zNSeUGp5o3Z8Xh/Y8fN7sos7
	9GSnxC+Uy+FW6AZKiuqZgyIzmiA4tgzRvQAE0/e01IotrvXk94LLIKyP2xHOSQO94vGYgdu
	FGCsy4Pj2b4euLFeJV/rDOpzMBuKzKBil1MuCZemaZZD2LGqD88+G6bvh+prehxJOVdM5hS
	G9bdQu2dEodDXIezCnh/YqsfGlA0NVyXng2zJi90vu4P9n95PUt8HwIyaIXTGJUU7szWu5L
	9lJqXqiNBFhXTzFHU8XxnfIza3u/hZ7wEav4mpwdLjcl34dhiUS0ybJDfNb5s=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

On Thu, Aug 06, 2026 at 11:01:07AM +0200, Greg KH wrote:
> On Thu, Aug 06, 2026 at 04:48:52PM +0800, Yichong Chen wrote:
> > +	mutex_lock(&debugfs_lock);
> > +	copy = kstrdup(*node ?: "", GFP_KERNEL);
> > +	mutex_unlock(&debugfs_lock);
> 
> scoped guard?

Yes, scoped guard would be cleaner here.  I can use it in the next version.

> > -	src = kstrdup(src, GFP_ATOMIC);
> > -	dst = kstrdup(dst, GFP_ATOMIC);
> > -	rcu_read_unlock();
> > +	src = kstrdup(src_node, GFP_KERNEL);
> > +	dst = kstrdup(dst_node, GFP_KERNEL);
> 
> Why is GFP_KERNEL now ok, while GFP_ATOMIC wasn't?  Is this the rcu
> stuff interacting somehow?

Yes.  The old code duplicated the strings while still inside the RCU
read-side critical section, so it had to use GFP_ATOMIC.

After this change, src_node and dst_node are protected by debugfs_lock
instead of RCU.  The duplication is done while holding that mutex, so the
allocation can sleep and GFP_KERNEL should be OK.

I will make this clearer in the changelog when sending the next version.

Thanks,
Yichong
