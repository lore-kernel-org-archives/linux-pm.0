Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389F63F410C;
	Mon, 20 Jul 2026 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558101; cv=none; b=FQfl1gu6368A041fBLkkj4Z8MIImJqoFzA9dv+ZBCkExI/GzZCVtDXbmj1XGsFmSgGOexanBZoTiPjUxNymqZvetH9TdYG5RKwI0Xg80A6jQPQzQxT50C95gr+EklTSwTlwIG2+lnsaBW38L23scA+Jbxp6F7Xl1rTjljGv7LGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558101; c=relaxed/simple;
	bh=ZVkkZ18OLSNZOkiVP1mnO/iPf2y1oqZNLduNfGDfsQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MTl5w4ffMDm75EqLo5NWfsffCujvEBdzR59CE+ix5k++hg783yFgqBZQesQgX7CVPjb3Sr6CkZuRWbfj8+aOcRwYKNvrXFt9ro3WNHMxYIJE8lVRpaOm+34n+FP9Tj9uKXu5oZWwKIdPYgLBnfployQoZ0hGwblYH92Zk9ALemg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=uKnkz66y; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="uKnkz66y"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 091DA143D;
	Mon, 20 Jul 2026 07:34:53 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 434DC3F99C;
	Mon, 20 Jul 2026 07:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784558097; bh=ZVkkZ18OLSNZOkiVP1mnO/iPf2y1oqZNLduNfGDfsQU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uKnkz66yIGd6UFYKjma27WX+h7RPQeiRRY0BIkl83q7LK9tzwmzAAWB3CpaLYSzSz
	 VAxrUqtdfHOxDU8UxXIgyQsQayXrfIiI6OfEhRpfdwO6iv7Qhs9TT/YU8rXJMUgOSF
	 KUIcW53yHOX72MUF2MwWNytURigfff8YrvkHQEak=
Message-ID: <c4abec80-2f8d-4070-aee4-76152f6f20cc@arm.com>
Date: Mon, 20 Jul 2026 15:34:36 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] iommu/fsl: use platform_device_set_fwnode()
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: driver-core@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 iommu@lists.linux.dev, netdev@vger.kernel.org, linux-pm@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 mfd@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-sound@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ulf Hansson <ulfh@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Srinivas Kandagatla <srini@kernel.org>
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
 <20260720-pdev-set-fwnode-instead-of-of-node-v1-3-2dee93f42c54@oss.qualcomm.com>
 <e4f9b266-8d9e-48fe-99c0-58b61e02c9bd@arm.com>
 <CAMRc=MefqCMgVv-o5hWoRwS2iXPQNs5nH2qHiz55+ew162LfSA@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAMRc=MefqCMgVv-o5hWoRwS2iXPQNs5nH2qHiz55+ew162LfSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/07/2026 2:39 pm, Bartosz Golaszewski wrote:
> On Mon, 20 Jul 2026 14:58:27 +0200, Robin Murphy <robin.murphy@arm.com> said:
>> On 20/07/2026 10:24 am, Bartosz Golaszewski wrote:
>>> Prefer the higher-level platform_device_set_fwnode() over the
>>> OF-specific platform_device_set_of_node() for dynamically allocated
>>> platform devices.
>>
>> This is very much non-portable code specific to OF-only platforms, but
>> if the intention is to remove platform_device_set_of_node() again
>> already, then FWIW,
>>
> 
> Providing platform_device_set_of_node() and using it was done to make the
> transision to expanding reference counting to all firmware nodes possible.
> I don't think we'll remove it just yet as it doesn't make sense to convert
> the code under drivers/of/ to using the fwnode variant.

OK, but in that case why convert these users either? If the OF helper 
does continue to exist then I'd imagine the static checker brigade will 
eventually end up sending patches to "simplify" these open-coded 
equivalents back to using it. And frankly, if drivers do know for sure 
they're exclusively dealing with of_nodes, rather than doing something 
conditional under an is_of_node() check, then I see little justification 
for them *not* using the dedicated helper.

If the complaint is that there are no *public* users to justify 
exporting platform_device_set_fwnode(), then as I say AFAICS that's much 
more neatly addressed with the static inline approach, such that we 
still get to unify the public APIs, actively eliminate something from 
the symbol table and save a bit of source and object code, but without 
any need to churn the truly OF-based callers at all.

Thanks,
Robin.

> 
>> Acked-by: Robin Murphy <robin.murphy@arm.com>
>>
>> (Although I'm slightly puzzled by the cover letter - AFAICS in -next,
>> platform_device_set_of_node() is itself very much a user of
>> platform_device_set_fwnode(), however in terms of symbol exports,
>> perhaps the former could now just be a static inline wrapper?)
>>
> 
> Sure that can be done independently later.
> 
> Bart

