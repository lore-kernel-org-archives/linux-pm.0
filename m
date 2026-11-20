Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795147367;
	b=MZQuMsI75VihaUClrTcJVYQ/PTZinbSSllgKTcUYGdBaBe5IAhfdLO4GZS5uqjTFJjHE
	 CfkAZaxxJzp6LPhqJILQTvakP/u0T5gsJ+C5qZpZjKoOOZ63uHcaLSYFHVVNvroWHWd2V
	 p4k+hUWv/GpE+9ko0zKGrN5p6tI3K9TpNFbgBq3NZYIauRoLs13u0CMfFuyHQcfMDG61b
	 GVzsBwxCpSqPEhul7jXCdetNTu/KnURmMgILeIjMuI49YRWEQm7lZ37q//y4kMzbokPW8
	 W5oswqgT4+3hEcmG1JDLeYPn4sbKpC2FQAam4PhoEeax67HVa5Ukmu2a4IQuZHe6SkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795147367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type;
	bh=TRNzUGKd2wKrR1v2ESH5QmUc5jp75PiKHVdd0VEreo0=;
	b=JpYZGY1O3t6XttegbSKqjN2z/BImR+gvNZQQYvV8cPNXftnnk6vNJsnINfus3zA/ocGA
	 IlLkWXY9qGiKR2fro+3YkdGaAx7rdFcxhgoUyI4mrnBjuzSFYbbc97IPkDDyZXL3qzIkx
	 BlI3okm6dnjp9sTN+lXZ9YVXFiD5BgH86tmtDpgaDpWM94/Gfz18uWU+uRH5LSnDmcR1w
	 yl06XpscXzHY6zANRrZ2mHsqKDzIsFXOvknNu/uTypmRLQ+NDIiWw9sldXlw0BS3j9+Wn
	 Ngfqn0gbAdWDev1u0IAHCkw+KkLERq7frWh9FQmyDII68VT1gazieJ1bayoQOR7bV6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SX+AD4Db;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C68606A320
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 04:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36C68606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SX+AD4Db
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-372bdb942dbso580542eec.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 20:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795147366; x=1795752166; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TRNzUGKd2wKrR1v2ESH5QmUc5jp75PiKHVdd0VEreo0=;
        b=SX+AD4Db4u/1rH6+ie25tXW4GxQhcJ+O567ogQJWIeCaFFcC/wn2bFB3i6t3NXc0dJ
         hZu+h1ypxP5/NGOyu+4Ww0lhN8bPxmwAcjj22EZtnZl7dwma5YRp1wT6ZeYSJAMkOnsn
         UoWaZp9jUk9ndt/Fcnll7b19qg4bI7Oz/dNAewKOdLWw98vZfCyG2FSI1izfT9xb5vYY
         M4a7cNk6VAQFIAtRUzsyMIkHENyeZ070KmFrn4V53ml6sdtriaxtgmSfsrt1fQIctx18
         JdgFT6i6v3GTuz5jgLdX+wC+/vO9J6hP6slNwKx4UGjzsDmrPwkF6jup7f6xUsbCy7/Q
         2JkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795147366; x=1795752166;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TRNzUGKd2wKrR1v2ESH5QmUc5jp75PiKHVdd0VEreo0=;
        b=TE4XGfobI/DM1HLxyYivvDrwZC0NNXGdGFVWfvgLLIPXIEAk8Edds2nHjCFpHEVdW0
         sD7EN4jb+zEvhYU/mZKNXISl7Wn0I1Gfprqmn13CT9MxN3hQCHzvdPyXsgLEvK8iZRBo
         bzTJhz9pF9ofbPADTmkAZA2NnViqrRTT8u6bG7S2NMOvWLSVFalrE3OL2ordnrzAv9tu
         SCQYLkOiiB9gyQNWE/qEBit/KxqoA/ugUAo+VDHtkg7F7cIAK1V915qIUN2HPIreC6we
         XjZ3yK8GisekJd3oowmhpmO0hvtDEJ+phek7pJW4GOcr4wKc0mRB55iG3x5rY7h1IesD
         Ho4A==
X-Forwarded-Encrypted: i=1; AL+hErGz8Th7Z/aXBfszQR139o/U8kXDnl0Snlk7LYxs8d+Gu4mDFPbiL4oHeTbi2TnUmI2yRRPr1fafDg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9AXr1EvrF0zgR4PlK1Opd9DT+mSVmbKErRCdRZxQ+2YSmXtpOt
	5R8Td79jhpEao4iSyKmLydITqC+6wlKPAEVnOclU1S3mw3FsAVtzZ8FB
X-Gm-Gg: AZFdTZdzRuVecm5/bo4SXhfyTIEsmbVHfgyMk3vf2lKAQ0IBwdgp0VwXEpLYDeozfcM
	r9trsTGuHnG183XHYebTTaee6v8Li5mOu2alS8ZMfPBW14PWQmuDl7NaVnMn0cn8SpKugIxWC6Y
	EtHpHxLJEF86uEfC4phzBxMkZF1x/me4xXqYiu9R4amIkOjS3t1+Vo5DXlX3nfmOM9gAv8n0NXe
	8izpByanckIQ3zz+BpuL73VH/dy4KuGQN2vym0u6ccppwJoN3uS+Iot0akc/8HCrbocqETXm4va
	jS0HV8n+KoJfuaALMpIHf2lxvKWLmZ5QT7QHplAuUI+o77at2+3L/DyIQZqv0DkAXftUL5aqPzv
	izux8j8PTS6e0y1Fio5dNjwUN2WFc41KEg8f/Dx6xjMsXo3TPbDz+AxeMVFzRN9lcvdGVktBxmO
	kCSGau7X5jKR04dMuR+KKSDY5957C4b9RO3uI9w8fKcKoyVDC7S++C1HAfuMCj5qFKRxFz7k23u
	+hOyUSYBDKV8XKfV4F00xY+lIK/nHeTnuVlp5f3dU4zlaqaaRLzACsYDZmDuNExGXIzE5FY5Z9f
	gGTJT1njXDJI85+tz4TqWbrPnkHdP5/2jvNIso4aLFtAQ3kwZgfpPl2gZAZ5y3Ud426r4Krov7y
	Q4p5fnKnhZVA=
X-Received: by 2002:a05:7301:259a:b0:36e:800a:71fe with SMTP id 5a478bee46e88-3856c4b844cmr1448219eec.1.1795147366198;
        Thu, 19 Nov 2026 20:02:46 -0800 (PST)
Received: from DESKTOP-7QP7L26 ([45.190.211.142])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567cafec4sm3663071eec.26.2026.11.19.20.02.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2026 20:02:45 -0800 (PST)
Date: Fri, 20 Nov 2026 01:01:56 -0300 (Hora oficial do Brasil)
From: dev12124 <joaoanandalima@gmail.com>
To: jasmeet.bhatia.us@gmail.com
cc: ilias.apalodimas@linaro.org, ardb@kernel.org, rafael@kernel.org, 
    pavel@ucw.cz, linux-efi@vger.kernel.org, linux-pm@vger.kernel.org, 
    x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] efi/tpm: Preserve event log without changing x86
 E820
In-Reply-To: <32909f9cc196a161bf380b6f64603b75@gmail.com>
Message-ID: <be1f79a5-6685-7188-9e79-05ba7acb98a6@gmail.com>
References: <cover.1788259938.git.jasmeet.bhatia.us@gmail.com> <a9e23066-aa75-44be-ac3b-9a15f4cf6047@app.fastmail.com> <DL6NCV1KQ9F9.6K6XZQCS4AF3@gmail.com> <c3ca811b-a6eb-4f4d-bbb2-4feef02e3db2@app.fastmail.com> <CAC_iWjL9jDsRaU7kEemYfwk292Nxa49cK0Rq=81pC=FWNRDhvg@mail.gmail.com>
 <b66f68b5220ddcadddb41340d3ea3388@gmail.com> <CAC_iWjJ1L5MYWy2vHG3AHYcfqx7urJmaTYP7vuyvZm8GSnWCDw@mail.gmail.com> <32909f9cc196a161bf380b6f64603b75@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="317403-16462-1795147365=:13716"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--317403-16462-1795147365=:13716
Content-Type: text/plain; format=flowed; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi guys,

I reviewed the thread and I agree with solution: Discard the TPM Event Log 
in kexec and resolves the hibernation issue;

Is a good solution.

Thanks,
João Guilherme da Silva Freitas Lima <joaoanandalima@gmail.com>.
--317403-16462-1795147365=:13716--
