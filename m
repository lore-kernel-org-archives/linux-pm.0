Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D122B1FD4;
	Wed, 25 Mar 2026 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774446308; cv=none; b=pfE0nvkjHQazp3U1OonlSWybDnauY0ll+NBor5VaKFvZ1kZYp3bbSVcRbCNjOOmfxyG2P+fzyvyjN9goCLgI+6XUDy1xgpg7nOSf8J7KZX9Zn7OIgPRzfXus6TPBwRqHVv9kdgEGRieNGlb+y4wC3qkQfeYMpfuteSgU/0PK6sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774446308; c=relaxed/simple;
	bh=zKis/CQLvh5YZsyeps6qK+9CG+oh5iNfz+RPkBDcT8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7SoJ/eQvIVjxvRsQyNonl/Jgvl+6bMlSiMx2w1t/Aq9z8nkuY5Xu/0MQWubeCeCIIRxWG+I0n3kxR3rqhcsQnfa1mOeejVQE/jbwjKZgJhi9NZRmH2jHXh6kEoqg0z1JQLeg2W+mjKxGKLExPBF3oMkTFS5QWs4CaGsAfLuY+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9X35OZT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9X35OZT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C62AC4CEF7;
	Wed, 25 Mar 2026 13:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774446308;
	bh=zKis/CQLvh5YZsyeps6qK+9CG+oh5iNfz+RPkBDcT8E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T9X35OZT/jI+mVLsmSZX4Fx8DFLv3YJ9Lk62GITI8IIwGniHpBxF1ta9AhRDwx3ao
	 QeVy9QWE6KexZz/Er92eN9JYYV6pnbwUg9qxRBWAJVBw/aFJnKjWKdEleQAqmnEaNz
	 Pt9jhclC0T2DSmdfKJF63w13ZP6446Abx+bzEjd4WVezIW3k1n73bM+zJ/3J2kIhYY
	 zTs71oJdlR7W+yA9ejyDs75/hCociOW9KZ3DtIz1dLeNJefVb++fEQ/nWoKGIjHP9p
	 TGFr/bwZul4zXUcO63YY+CwCkUMrekii2JsFzsbrBU44qeFobhEaqraJv3s8twb4yJ
	 IHfTh071rxz3A==
Message-ID: <b69cc187-6ef3-4390-a0cb-f36a2295c6f2@kernel.org>
Date: Wed, 25 Mar 2026 08:45:05 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/12] amd-pstate-ut: Add ability to run a single
 testcase
To: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20260320144321.18543-1-gautham.shenoy@amd.com>
 <20260320144321.18543-9-gautham.shenoy@amd.com>
 <0b1f1901-8ea0-4b68-8887-29e88e86ab60@kernel.org>
 <acITFNYfjSMc/K1I@BLRRASHENOY1.amd.com>
 <554baa52-c181-4dcc-a77a-ef8f4e0be763@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <554baa52-c181-4dcc-a77a-ef8f4e0be763@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/24/26 23:28, K Prateek Nayak wrote:
> Hello Gautham,
> 
> On 3/24/2026 9:59 AM, Gautham R. Shenoy wrote:
>> +static bool test_in_list(const char *list, const char *name)
>> +{
>> +       size_t name_len = strlen(name);
>> +       const char *p = list;
>> +
>> +       while (*p) {
>> +               const char *sep = strchr(p, ';');
> 
> Any particular reason for using a ";" as the separator instead of ","?
> 
> I personally prefer "," because with ";", I need to explicitly add
> '' around the test_list otherwise bash thinks the command ends at ";"
> but with "," that is avoided.
> 
> Thoughts?
> 

Sure, that sounds like a good reason to use a comma instead.

>> +               size_t token_len = sep ? sep - p : strlen(p);
>> +
>> +               if (token_len == name_len && !strncmp(p, name, token_len))
>> +                       return true;
>> +
>> +               if (!sep)
>> +                       break;
>> +               p = sep + 1;
>> +       }
>> +
>> +       return false;
>> +}

