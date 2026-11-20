Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795191104;
	b=sw3j1LZBhR5GNK7s2F8s+EOr/zofADL7W3QhqHY9Nkv3FZnU54BwJTZyFgJdZWUs+jxU
	 +yMt9NlBspLBwgB+JJUVMEok7Zvn1n2kvNZv/4/p16ZxtiZPYeNclStPGLAaou+G2n0nI
	 oLUeOFpm60o3WBevShuHuC3pDdc2mHLxg3ZLnzS0Mvsm+lXwNqze9V1nbsNFC+t65CkeC
	 7f0ighIG5kDKFunI90Uh+hydNQLbRvx1acRrbBqycQBSXFu381etytpDQ4T+8pqNl4PWu
	 LuMZAX62cgtcSOypcIi8yfId48u7DfTTSHKsqbw0biXCs2uisSlCa7ywyGOdX6cjk0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795191104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=ACIXcHO1wQS5t52irVr/vPmSpLKY1T/AIbYzAIeE1Fg=;
	b=NMtVvvgQqaoSoLJKniKZuDhA1ZuH+nc17VoGNnTdi8C1RdVDqcXVaeHT9joFPUUwCStS
	 Vjj+QBbXB8pThLdm+BoY9OARA3CA3QAzVosJSM+BBv6KmDLrAXdkZSc3GhGWWjFCjNCIT
	 9LK6V5ayvmDFeLR9OkIy4q4LaHGs9vAXAb5Q8TsRlOIxhc1gy4baLyn9/au0iYw+Cs7UT
	 Eyt/f/JBVkE4Rp41T2NzuCPrzJo8eM+7+Q9I6v47RcFvWWWAI+3xLgZm5Rg3/P5EQH5Ph
	 hhdkwuqDbXgHK4+a8YPvpndJcMzgwEpaaCVbvw3hUeTVgCSZDvyCZwNGv/b6nGxxtxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=g87FjcNz;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28F2606A325
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 16:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A28F2606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=g87FjcNz
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-94999a08973so108629585a.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 08:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1795191102; x=1795795902; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ACIXcHO1wQS5t52irVr/vPmSpLKY1T/AIbYzAIeE1Fg=;
        b=g87FjcNzENChsqegY0F4YAZKnElVMnlWdV8x0KcmrJW8N4F++cXGtAtYp74tvMP4NJ
         uRcZCG4pp5SPY0DiQKy5BbFboKi2837mQvqZ3FeCRlo9Eq7ntvhtAXvSYprUAPYhGNNt
         TEQ2WagjXxXlDQ47NJfhXg0XCxvcLz6gj50bq299qJHm/82O7upGtdbk9rsXSXQ+pMd1
         LYUiILJCzE4dtGEq7AgvjtuCQ8qklbaT1Gy0PAzTAqwDUoPKzXD10pNa4RTSYKzh3fGk
         8cg7d8Qwr47CE3qYrqpIowAkjYQIhUpR1uImByDxO7HtXBR0QzVso2Wrc842LZe4OSCE
         OZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795191102; x=1795795902;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ACIXcHO1wQS5t52irVr/vPmSpLKY1T/AIbYzAIeE1Fg=;
        b=WYdzQwiidkIhaYsrcftRhjszleJhZPRAv9O83znrtqmtBXEV3g/CEE6/fATMc23bqW
         JFplYjTE9vqaHZDcJGJDcbmtXLUpR9GnCZ+YaJFiqVMRwrW1ty+rR5zHWwvxiS6hUVZ9
         pKf1I9ImlXAnDu+2nckEQWG5CHw51eWhZK0WS3oV1XspSwzIrRUC96lOvyoGgFmwKKX7
         B4RU+mfCmE7Yw3xy7DMV5SADtWo/s/Lvsyayw71lIHIkPJsMYoylMZ3fL0LdUbC57rAH
         hna9vXYQ6j1aZTpgfU+INct7M/UhwthMosflnQ10tTOnbQ20kDAdQKoH8IzBCvCspp13
         wYfQ==
X-Gm-Message-State: APuU4Z+scLvhyBaMQoUdtO4jey/IJ+k/uEgp74U3W/bWZnyaYtfkvaeH
	NsUjnyLAYUqqftj6IvqBNA/M4/uGja0x99aiBp3ZZfSMGte7GgHULnq7fI+WAb5zlg==
X-Gm-Gg: AYBFou0bb8rZQVzP6cyKPW5h4FVQWytteZCb9iHOtJPvUOES5pW1Y5Y9FM3sjYkDCEa
	1z9IQyEYKImuUt7iO4CP5YLiOlGoWJFnTERg7teKM+bESeQt/W8uMDI5MFdZQRS8IS4NTeXqqEn
	9qHFsRfGvNsjEvUTiQmyXgjeA5FVTbUh4dXcM7zVU1dzJsR4Q+Fy5Vv/dUt3/mt50QlcmCMVF7r
	cB1fCaH6wpeM0IMtXJpbOnWadrDNsv0NgZPxIBJn89oGAjesLbjaiUy1GFt0aOB4ji4Fk6AXu9M
	/GUwXNNvFc2KmZUh3WyZtDgl3dv8F2Zr6Fe4kGbWUG173UsAnEUTji6qBPLYM+izqdJGzhJr0wJ
	1AwWYkmLWMpkgxMgDwzCo59cj5lBpSUzkCAr3DNCp6DmccywOSgFY/7APGqE5J9tNWjPy2W1oh0
	MaRePJ/xcvNxlZRHzf9XYrnclYOcvNglbjDrCIIAVKCPX5uX6NFf5CpJjMsICvSIOTjAeSydQOD
	ai1e8BrjWdIsfICBJKc4VNpbt5mNKrmlIgw2Lkz8lzB8RSlspvg8RfFa/4cFgWEJBxy6Ve6c+wK
	7JhfN7ik4u4wxzaL3cMIcJ5x9eD7cQ==
X-Received: by 2002:a05:620a:46a3:b0:949:7069:3fab with SMTP id af79cd13be357-949bab3e9aemr621786085a.83.1795191102506;
        Fri, 20 Nov 2026 08:11:42 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d00:161a::d398])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb427388sm213666785a.42.2026.11.20.08.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:11:41 -0800 (PST)
Date: Fri, 20 Nov 2026 11:11:39 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
	Linux Driver Core Development <driver-core@lists.linux.dev>
Subject: Re: [PATCH v1 2/4] PM: runtime: Drop space characters preceding
 labels
Message-ID: <2edb9ce7-8ea7-44ff-b5fa-38e9880510fc@rowland.harvard.edu>
References: <1978814.tdWV9SEqCh@rafael.j.wysocki>
 <3453847.44csPzL39Z@rafael.j.wysocki>
 <c1a2c90f-c667-4bf2-bbc0-2cb3f840ad97@rowland.harvard.edu>
 <CAJZ5v0jX8iR5x2eS1uAf_P12Ke_OBq6kx2FRCiVuSRRRDgMzLQ@mail.gmail.com>
 <CAJZ5v0j39Wzb3F+ACHC+KM49oruUuekN3fDzJFcfHTtnDXqk+g@mail.gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j39Wzb3F+ACHC+KM49oruUuekN3fDzJFcfHTtnDXqk+g@mail.gmail.com>

On Fri, Nov 20, 2026 at 01:30:14PM +0100, Rafael J. Wysocki (Intel) wrote:
> On Fri, Nov 20, 2026 at 1:11 PM Rafael J. Wysocki (Intel)
> <rafael@kernel.org> wrote:
> >
> > On Fri, Nov 20, 2026 at 3:47 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Thu, Nov 19, 2026 at 09:17:08PM +0100, Rafael J. Wysocki wrote:
> > > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > >
> > > > Drop space characters preceding labels from the core runtime PM code.
> > > >
> > > > No functional impact.
> > > >
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > >
> > > There actually is a valid reason for keeping the spaces before
> > > statement labels, although you may not agree with it.  Namely, the space
> > > prevents "diff -p" from thinking that the label is the start of a new
> > > function definition.  That's why I put a single space before statement
> > > labels in the code I write.
> >
> > But this is not done elsewhere in the kernel and there is already some
> > inconsistency in that respect in runtime.c.
> >
> > Since the next patch is adding a new label, I thought it would be
> > better to make it all consistent first and I chose to follow the
> > common kernel coding style.
> 
> I can drop the $subject patch though if this is an issue and make the
> next one put a space in front of the new label.

Oh, it's not a problem.  I just wanted to point out that putting a space 
before statement labels is not a completely senseless thing to do.  
After you've read a few diff listings with statement labels where the 
function names should be, so you have to match the diff against the 
original source to know where a particular hunk belongs, you understand 
why.

This is your subsystem; you can solve formatting issues however you 
like.

Alan Stern
