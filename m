Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795781559;
	b=JASSpWp5OgKJCVIcICx0Y7S0YpFAVgENx5Xukziqle04xYfR/BWJEhTUCEbbeUgBPnHy
	 Rtk3Fck2JsEuhsZDTZVk+9tOxnm4rj+yJSLjAt/GH0jJJNPAuB4/q9a5TWQydjnXeVmrz
	 t3QvSy6q3Dbv7XISEjWgKLsru4OAaG/aiXsBFZU2q/p57G7cpwyd56R+Pc6RlHqE3Wd4j
	 3DIR1tRM8wDxtXMA42Ujf1H+H7Y6uD8hxSsA9AgEqBjNgohyZNk8zP7DaQYVyjuyz0QEk
	 OOV2OeX8CC9vwjalwNRUKcYbN5MnGPC+A2vVMkDWvB1ddGOwBxuHopBKtZ6eEJQO5HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781559;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=bgsXrW1L7I50f6348fPk60A0WzJDFn1VjlNjUkAZEqA=;
	b=f5AmBWnyfc5JfjcBfvGzlXKDhjR7AlsVhElTY9jhyxm+WxtyUg54X9KtkeHfr8wzrMBn
	 MA+p03dNJ6KKJKVvuLfZt4IKSChD0pBLpHuT9pVEnUYHFtnyLfI3mxChuIkigen15Vh/w
	 SN6bpfcWnhdAx0ziW62UMnKtKFkLMR2W1QOwqWR23x4BxpJ1zS7HQ4pkpw4D6XMo3macP
	 +rUjtbl6omeBslU5v9XsZ444zBH2Az3m8BfpnyyaXtMm3HaCLtjslkUKD3L+eB1wgq2b7
	 tC3wGROmB5pe1K4sdhqEY4O5AsBCIdCa7ps+t3GgUAVzXow6IJiLrM04AM4a270KrwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=LEQkPCfW;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C6C606A327;
	Fri, 27 Nov 2026 12:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02C6C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=LEQkPCfW
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3B002145C;
	Fri, 27 Nov 2026 13:10:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1795781401;
	bh=3vvPIXNCXj7hgbbQxA0L1qhL0eGm3PomxB/htctH7xQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LEQkPCfW1nh/CYDvtPCY3IK4QaBj2ypTtfyMQ17ucANCJxcUEah3MaEHpjePyJ1aF
	 Uly3lL+LsLdAgT4m95Sg1z9nmtVb4aZLTXiRchDGWUEui23IHQ0bx0v1lfigq8nV6i
	 AbnfkORiTiOPuJD1wUcsHgae0npE/XNZzcHX67bY=
Message-ID: <5c7fd300-a0bf-4593-8777-5577df2fc859@ideasonboard.com>
Date: Fri, 27 Nov 2026 14:12:33 +0200
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: core: Add genpd_dev_pm_attach_by_node()
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>,
 Ulf Hansson <ulfh@kernel.org>, Devarsh Thakkar <devarsht@ti.com>,
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20261023-pm_attach_by_node-v1-1-4dbaccdf8b0e@ideasonboard.com>
 <CAPx+jO_FC1t_UaDfQDPOCy+V-Zdc1b5h5krrppGvYiW-LsD3LQ@mail.gmail.com>
 <4fbeef8c-1dc8-4cac-a4af-835037c3dc4b@ideasonboard.com>
 <CAPx+jO_5OK_9VJo7vh0CP37-fTkd_2j3XtyGkTw3bz4heyYq6Q@mail.gmail.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <CAPx+jO_5OK_9VJo7vh0CP37-fTkd_2j3XtyGkTw3bz4heyYq6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ulf,

On 27/11/2026 12:57, Ulf Hansson wrote:
> On Fri, Nov 27, 2026 at 10:07 AM Tomi Valkeinen
> <tomi.valkeinen@ideasonboard.com> wrote:
>>
>> Hi,
>>
>> On 25/11/2026 14:50, Ulf Hansson wrote:
>>> On Fri, Oct 23, 2026 at 8:17 PM Tomi Valkeinen
>>> <tomi.valkeinen@ideasonboard.com> wrote:
>>>>
>>>> genpd_dev_pm_attach_by_id() and genpd_dev_pm_attach_by_name() attach a
>>>> virtual device to a PM domain listed in the OF node of the passed
>>>> device.
>>>>
>>>> Some hardware blocks are described in a child node of a main device.
>>>> They have no device of their own, but they do have a PM domain of their
>>>> own. Neither function can attach that domain, as both parse only the OF
>>>> node of the device.
>>>>
>>>> An example case is TI's display subsystem and its OLDI (LVDS)
>>>> transmitters:
>>>>
>>>> dss@30200000 {
>>>>       power-domains = <...>;
>>>>
>>>>       oldi-transmitters {
>>>>           oldi@0 {
>>>>               power-domains = <...>;
>>>>           };
>>>>
>>>>           oldi@1 {
>>>>               power-domains = <...>;
>>>>           };
>>>>       };
>>>> };
>>>>
>>>> The OLDI TX blocks are not part of the DSS IP, but they are not quite
>>>> real devices either as they don't have registers of their own, and are
>>>> instead controlled via DSS registers.
>>>>
>>>> Add genpd_dev_pm_attach_by_node(), which is similar to
>>>> genpd_dev_pm_attach_by_id() but instead of looking for the power-domains
>>>> from the passed device's DT node, the DT node is passed explicitly. Also
>>>> add a matching wrapper function dev_pm_domain_attach_by_node().
>>>>
>>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>>>> ---
>>>> This is a new try for managing the OLDI power domains. Previously I
>>>> tried using auxiliary device/driver for OLDIs, and handling the PDs the
>>>> normal way:
>>>>
>>>> https://lore.kernel.org/all/20260529-beagley-ai-display-v3-12-7fefdc5d1adf%40ideasonboard.com/
>>>>
>>>> Then I realized an issue, mentioned in
>>>> Documentation/driver-api/driver-model/driver.rst: "-EPROBE_DEFER must
>>>> not be returned if probe() has already created child devices".
>>>
>>> I don't follow. How is this a problem? Why not create the child
>>> devices at a later point?
>>
>> The problem the above text refers to is (as far as I understand):
>>
>> The main driver probes, and creates a child device, which probes
>> successfully. That causes the flag for "run deferred probes again" to be
>> set. The main driver then continues its probe, but, for some reason,
>> must return -EPROBE_DEFER. But as the above-mentioned flag is set, so
>> probes are ran again, resulting in the same sequence, again and again.
>>
>> Creating the child device later is difficult. We have display pipelines
>> which contain multiple independent devices. All those devices must have
>> probed and their bridges/panels registered to the DRM framework so that
>> the main DRM driver can finish its probe. If parts of the pipeline are
>> missing, we return -EPROBE_DEFER and wait for the missing parts to appear.
> 
> Well, I still don't see why creating the child devices later is a
> problem. In fact, the opposite seems to be the reason for these
> churns.
> 
> Usually what we do to solve this kind of problem is to make sure the
> main driver for the parent device has completed its operations for the
> probe and then it populates the child devices. If that doesn't work
> for some reason, the main driver simply needs to remove the child
> devices in the error path in the probe.

Yes. And this works fine, unless something can cause EDEFE_PROBE after a 
child device has been created.

> If the main driver requires the child devices to complete their probe,
> an additional synchronization mechanism needs to be added to allow
> them to inform the parent.

Yes, I think the component system can be used here. It just adds a bit 
more complications for a seemingly simple case.

>> And the OLDIs here are not really independent devices. They don't have
>> register space, and OLDI configuration is done via DSS registers. Yet
>> they don't fit very well inside the DSS either, as they are clearly an
>> outside IP, an external encoder. So the aim has been to represent them
>> as separates child DT nodes, which allows setting OLDI properties and
>> the media graph, but there's no compatible string and it's the tidss
>> driver that fully manages the creation/cleanup.
> 
> I don't see how this is a problem. It's perfectly fine at ->remove()
> that the parent should be responsible for removing its children,
> right?

Yes, my point was just that the OLDI is very much tied to the DSS, and 
can't act as a separate device. But I have to say it's a bit unclear to 
me what is a "device" and what is not =).

>> Here a simple pipeline could be:
>>
>> DSS -> OLDI -> panel
>>
>> If the panel hasn't been registered, tidss will defer. But tidss needs
>> OLDI to be there too, when it binds the display pipeline, otherwise it
>> could never finish.
> 
> I guess "finish" is the important word here. Finish doesn't
> necessarily need to be the same thing as that probe completed. This is
> what it seems to boil down to.

True. I am quite keen on keeping it simple, and managing the DSS and 
OLDI as one "thing", so tidss probe handles OLDI and when tidss probe is 
done, so is OLDI, and so is the display pipeline.

The alternatives, e.g. with component model, are always more complex to 
write and maintain.

>> It is possible to create the DRM bridge entity for the OLDI without any
>> OLDI device/driver, which allows creating the display pipeline. But the
>> OLDI bridge code has to be able to enable the OLDI power domain, and I
>> think the only way to use PDs currently is via devices.
> 
> Correct and there are good reasons for that.
> 
>>
>> So if we created the OLDI DRM bridge as mentioned above, then later in
>> tidss probe we could create a device for OLDI, which probes and binds.
>> That can then be used to control the PD, but there would be no other use
>> for it. And the sequence feels like doing it backwards.
> 
> I am not sure this is backwards, at least if we compare with how many
> other subsystems/drivers are doing it.

What do you mean? Usually the driver probe registers to some kind of a 
subystem/framework. Here we would first register OLDI to the DRM 
subsystem, and afterwards create the OLDI device and its probe would be 
called. That feels backwards to me...

Or are we talking about different things?

>>>> The PD virtual devices used in this patch's approach do not hit the
>>>> issue as they don't get a driver, so they are not probed. The tidss
>>>> driver's OLDI part can then use normal pm_runtime_get/put functions to
>>>> manage the OLDI PDs.
>>>
>>> Sorry, but this makes no sense to me. Considering the above statement
>>> about -EPROBE_DEFER and child devices, it sounds like we need to
>>> manage some kind of cleanup in both solutions, right?
>>
>> Yes, but with PD virtual devices there's no probe, so they don't cause
>> the "do deferred probes again" flag to be set. It's not the cleanup as
>> such that causes the problem.
>>
>> In some ways this does feel a bit like a work-around to the framework
>> limitation. Representing OLDI with the aux-bus feels quite correct, I
>> think. But then, all that plumbing just to enable/disable the PD...
> 
> Right, but the plumbing sounds quite straightforward, especially since
> the auxiliary bus would solve most of the problem for us.

It doesn't feel straightforward to me... We have two ways:

- Essentially a single driver and device (tidss) which supports OLDI. 
Probing, removing, life-cycle management is simple and clear.

- tidss as a parent device, oldi as a child device. Separate 
probing/removal, life-cycle management tied together but still not the 
same, setup needs to be done in stages instead of doing it all in probe.

It's not rocket science, but it's still non-trivial, and only to be able 
to enable/disable a PD.

> More importantly, I really want to avoid introducing another API for
> attaching to power domains.

Fair enough, I'll look at the aux-bus again.

Btw, this can be done without new APIs, without aux-bus. Afaik the same 
thing that the code added in this patch will do can also be done in the 
driver. So tidss would just create a minimal device for the OLDI, 
without a driver, point it to the OLDI DT node, etc. But it feel a bit 
like cheating... =)

> To solve this I suggest to re-visit the auxiliary device/driver. It's
> also important that the created auxiliary device gets its fwnode
> assigned to the corresponding child node as in this way, the child
> node will also be properly considered for "sync_state" for the
> power-domain provider. In regards to the synchronization with the
> parent, I suggest providing a platform data for the auxiliary device,
> that the auxiliary driver can use to notify the driver for the parent
> that it's ready.
Yep, I'll try to come up with something. And, indeed, perhaps the 
platform data can be used instead of the component model, maybe it's a 
bit lighter.

  Tomi

