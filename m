Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795015080;
	b=WbEM2wj10AqAR7KdOfUkGOE0MO8zFrHzjOSFpbi0XHsq4+cdNniQNVb87k5QY4y0LCfL
	 NCMKbfYQ/G61PruxbiXxm2WhmRVKMSZepV5JE6yTNEYB1r1CpNf2Ih1fj0bmsPzFNQFig
	 5/2aOHiaFFiGiXEcyI4jpWTsvu6unMmdpcoH2uy4B8bFng8I2lzkjDTfVKL0p8sPhMD94
	 xI6bfticIbSM6Sfo1Qc6c3V6IEHYE59NZeL9AkF6bUmEACo0pK32dCorM3tTvNj7kTBHB
	 +8AnyyMepbcWjChf3tPRFwauR6s7qu1ZelUXCJi/KrtFfIxhTaCD6Dmli4NfPnAuHRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015080;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=NayqA+2VU8BL3bQ4QlYOm2bPtjimdoFBif/UfurJ/Ic=;
	b=rXueRf4QeiuNXXZWgUxkVmj3v79jyUn4dJw15gZLpiwIpAqnoIEf8HrkazyDfF2ONXiZ
	 UlV6FJvDRk3mc/IFIHRV2UV0gLqypZAygB7T5QsGithg42XfWbj2H2NZ3yDIX42R/I4JN
	 4O0e4/auGbxSxLlFEQKu9ZrGiz1FbkIRT1UL60Ma/sJJPeYMMA8OpQp77GwgjV1agELyi
	 RK4bVXJrqGopeUvsHDDReLWOciAStOGKqIHowLq9f0pXO/jpGMe13lj6L47wJ//ChL5eo
	 5W9mEt84LrtLolWcqN1E0MXbD2rUNd+hsO1Gd4VnUwxBnXDYjFCPo9CYk9L47ZhOW+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=e4KQUABj;
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E892606A331
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 15:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E892606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=e4KQUABj
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91e8a05ec5aso12854546d6.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 07:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795015079; x=1795619879; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NayqA+2VU8BL3bQ4QlYOm2bPtjimdoFBif/UfurJ/Ic=;
        b=e4KQUABj7gEeUxSS/9AWkxdW17UGKfzuGQLoVBznmZ3Gt2tw44MXP7MS7fuK4a6Xch
         0yyAXWnxxjkzZiP8jzIwtt8wLQB5Qssy9Gb6kZK/rHIv3jESaumWf1ihxu4gqfy3WHhI
         oFqLxTx/jKx8gn2+JTWAhEQk7YXH4RcTH2yez5MsQAFrIf799A5J/GHOpS52hUYhDizF
         brNl3q2lSv7Y6eahBplN+1C7QJXZuPwNsoam+lFO8Uv4TSMXFVNwxTf74WshGCQjFYLx
         AQVaoBNexrSRe/cQbkOsywEWMHGfpBC1GgvoSO70//W1ftEDbFrlxKA7Po9FCE5MnZw0
         zQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795015079; x=1795619879;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NayqA+2VU8BL3bQ4QlYOm2bPtjimdoFBif/UfurJ/Ic=;
        b=J4ImXGkL5dLdTzkg2MRkx9kETmwBcnvpJzf4g3F6Oc0d9RT+6Hl9c8M0Gn3EE+mcFE
         UVqvkX6O4ySv0l0jjsJ33ValKQpk46VEJu4u1GGYVTcz3gOV1TGiKpNQs93cgsOfDJy5
         ykiHPCxFin48GbpR/DSiXGz8SAlsH9MbbA2c758dIz3qzduMfJWFft2GOKrVIPJXi4mu
         ZTSwoCxSSKIfx80GPPLKthGQ4bj3JOH0FiC6qAd/luVrZzzhgAvucW7alLhdMI4q02Ve
         R+KE2/MBKxCLzGvg7eu6zAM+EsGhS6q5nvzC/KokaJRK8EjR/QBJHjPq9IiG3PM+GgaE
         I0rA==
X-Forwarded-Encrypted: i=1; AL+hErEko0vDBDBRb1/ttY57vsqzC091U5uVVPCvQS+UD4zbaRVEYWUYmTAArjNdVoYrmK9UG9JbDJOQuA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/MUFE6amtGw3nlDJYe4hD+UKFEC4ztgblR2kPMIIE4NXoUogLk
	zGLGN2lgqKuc2suDaqvqYLIftWaNJa0YU74MusiDyGEMhu6eDMJP8qPgIShHLpYVQ7M=
X-Gm-Gg: AZFdTZd69Orj5s53bbT/H/ADlX9zsmt1x/8YouNCGP5tFTjkMCWpJYp5zvW9e+bEV23
	7ZuhEHNydRTSS2K8ztf9h4kuwhwSqJiN0VFPWdJqBV6wip4uDj3ajoJ0GzkEk2osk1kLhkw4DV3
	XWv7nJjK6lclwGb89BY1zY9N/P3HMoNV5q7uVcM1dm2lNXutfLB6587d/FMy0M0Atn/4Ao+bgK+
	e5vMWs5DdH9sYA2KM2kv6R0/5bV5NgL3u6t+p4VE24araOO5qxglo8pY1hr+agXNrghe/OV71GE
	ISg3uouOBvT2JECfk+qsfOxTQNKJ88GJdfJy0Vywr1dtxvXw30sl0DuOibXO0vLukAteRYJHuoB
	s02CQMhhOYyVofnmMHjgQa/nq+qRzKp66w5qf4So0KDSZW6GlVm0ov86xYFGF6XAElmagRPd/+Y
	tahMQHmyEa5rmSP242F1tsNAQhMMbnuBszcCGi0vy8hRXo136OjkMd9A5hvGNrqlNlkXFd/1jJU
	20xRBEHtV9yupYJ+G/jsXc3WmGhBxonTbwZYWO4CB11i8Knbqzbr+GdbH9A+N1HRzW3fy7uTHJi
	KF/ke59KVEYFOv7MOWVn0+ZuYi4/mYY6ByI3PLsu1cbTTzhtSGC6H7UG1/rDtGs4cpLIlQbTLUN
	rCCIluyzeLTAVY3zAx8J9TpkAxU4R
X-Received: by 2002:a05:6214:5d88:b0:91f:2222:b498 with SMTP id 6a1803df08f44-92114f8f66fmr40206726d6.27.1795015079071;
        Wed, 18 Nov 2026 07:17:59 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92114d35dabsm23793796d6.17.2026.11.18.07.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:17:58 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/22] mm: add node-state-filtered zone and node
 iterators
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 linux-doc@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-serial@vger.kernel.org, linux-pm@vger.kernel.org, 
 damon@lists.linux.dev, linux-cxl@vger.kernel.org, akpm@linux-foundation.org, 
 david@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
 surenb@google.com, mhocko@suse.com, corbet@lwn.net, 
 skhan@linuxfoundation.org, rdunlap@infradead.org, 
 gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
 johan@kernel.org, jirislaby@kernel.org, kasong@tencent.com, 
 qi.zheng@linux.dev, shakeel.butt@linux.dev, baohua@kernel.org, 
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
 baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, yury.norov@gmail.com, 
 linux@rasmusvillemoes.dk, pavel@kernel.org, lenb@kernel.org, 
 hannes@cmpxchg.org, brendan.jackman@linux.dev, ziy@nvidia.com, 
 sj@kernel.org, muchun.song@linux.dev, osalvador@suse.de, 
 nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, 
 lance.yang@linux.dev, usama.arif@linux.dev, kas@kernel.org, 
 xu.xin@linux.dev, chengming.zhou@linux.dev, joshua.hahnjy@gmail.com, 
 rakie.kim@sk.com, ying.huang@linux.alibaba.com, matthew.brost@intel.com, 
 byungchul@sk.com, apopple@nvidia.com, rientjes@google.com
In-Reply-To: <av1hKrtcATVjCnCM@MWDK4CY14F>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-2-gourry@gourry.net> <av1hKrtcATVjCnCM@MWDK4CY14F>
Date: Wed, 18 Nov 2026 10:17:57 -0500
Message-Id: <179501507729.1206716.6880334614636468959.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-18 16:29 +0800, Richard Cheng wrote:
> On Sat, Nov 14, 2026 at 02:09:38AM +0800, Gregory Price (Meta) wrote:
> > +/**
> > + * for_each_zone_node_state - iterate zones in intersect(nodemask, node_state(state))
> > + * @zone: The current zone in the iterator
> > + * @z: The current pointer within zonelist->_zonerefs being iterated
> > + * @zlist: The zonelist being iterated
> > + * @highidx: The zone index of the highest zone to return
> > + * @nodemask: Nodemask allowed by the allocator
> > + * @state: The node state the zone's node must be in
> > + *
> > + * The state filter is part of the iteration rather than a trailing if, so that
> > + * this expands to a single for statement: a macro ending in an unbraced if
> > + * silently steals a following else from the caller.
> > + */
> > +#define for_each_zone_node_state(zone, z, zlist, highidx, nodemask, state)	\
> > +	for (z = first_zones_zonelist_state(zlist, highidx, nodemask, state),	\
> > +		zone = zonelist_zone(z);					\
> > +		zone;								\
> > +		z = next_zones_zonelist_state(++z, highidx, nodemask, state),	\
> > +		zone = zonelist_zone(z))
> > +
> 
> A question on consistency. This one is a single for statement, with 2 new helper functions.
> for_each_populated_zone_state() in the same patch uses "if (!cond) ; else" form instead.
> 
> Both forms keep a caller's else correct. The only difference I can find is that the if/else
> form give a -Wdangling-else warning when the loop is the unbraced body of an if.
> 
> Is that the reason for the 2 helper function here? If the warning doesn't matter, this could
> use the same short form and drop the 2 functions. If it does matter, should
> for_each_populated_zone_state() be a single statement too ?
> 

Yeah I was getting that warning from various checks. I'd convinced
byself this was a false-positive, but it does look very funky indeed.

Let me look into this again, it's possible I can massage this better to
use the short form still.  It's also possible that I should just use a
different shape entirely than trying to use the existing pattern.

-- 
~Gregory

