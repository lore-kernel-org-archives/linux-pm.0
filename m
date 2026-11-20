Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795203773;
	b=CKISilQPGNFuOicAA4qdADn9mmERuIJFxPtWcJhkPUzaabBEImpIsdvu17qyzbcQU4aQ
	 ea5GjBU2eKNi7eYz0Y0I8txcwUbqrR4OHMbZjLliImUrfVU2BopXLOOZixcNr+ECBOJhL
	 NRjgZl8glIoAbx5YQAz72I+cBPTKVLcLjqv2aUaDCp6rbo71Ku3S5AAQL+3mMhA19Ejhx
	 BN3K2pNYBDBxf8zdbs7evsF4B42YTo9xwAJ8vxvLqclq+KrcCrzb+1l+0yjANA11LyADY
	 U9NmB2gvL2Rjk9y5OptVqvXBODTGcDUEa7d6trkocyX4Mj6rpFA9pQ2bTGtm5M2zWIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795203773;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ey4BARBqKVgHTpjXI934Cp4pUPX1BMBQAdK/nc3RIDE=;
	b=1PFFmvIUL8/5JQtQCiweXL7Xi6Y7JX5yet9P2ijmOJCRXRH1XT+M0b+c4DDiRaRFwGK1
	 /hWJQVpajsTZ6UKsfHfmptdFhvKBh+b0OU21M/1KXs6TjNdhVsWsPHp90L/G42NY2EZLm
	 1m/T/Jx6Vat8VS66PKN+zntUyHaeofPCyvucFowx01RK3E3ElMjr7Q/nT38j8fGyIRMJQ
	 ioe+QypslQlhPGIZk/fSeAG46pkyyBNYEV9hLdIV2jPKYKUpmNp/4p+35QT8EUG41MsaB
	 hsIXfDvGSCvxpgsSp4SmRSB16NZpxDZf1vl16WXhbE4R2zGmsBM4G53Ih7Hevt4EI1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=RUeGI5lK;
	arc=none smtp.remote-ip=209.85.160.42
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4B6606A6F2
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 19:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC4B6606A6F2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=RUeGI5lK
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4adae187d94so855023fac.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 11:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1795203768; x=1795808568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ey4BARBqKVgHTpjXI934Cp4pUPX1BMBQAdK/nc3RIDE=;
        b=RUeGI5lK3Dpk0NwUBBzi5s8GkuFymZyBlP6SyDJL1s1m30BgMAhNyjFFjOcZ62z5LZ
         xD6rrw4RIEWybtDbc/wQFbsZ15jZHsQhjNQXgFL7U52DLDEXIy748sdDBeBzlCN6dgPD
         C/k1of20KGGfVppHVJuq5oQ6HPX5xkKmkxUq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795203768; x=1795808568;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ey4BARBqKVgHTpjXI934Cp4pUPX1BMBQAdK/nc3RIDE=;
        b=jeC6Q8hwey9Dxu5C/3U4MGjC+ochgLaLFfo7J/8XW4dmxFsMoUJoZJvb/l5Umk+g6Z
         8B8A+MkwHfQ1vePM79GWjIOPC+rjPjO+Jp5DpDHHKsbzJ/80kqvidKHFprjGiFaOYkW8
         OpukA1AbGTBexRI0pPmNd+I4GmNmewvq9fik1z7rNiQPiNxfHPZWTvaurxEOvlLmYafp
         CdGI+GbsxGJkUaGdmG2g83nBrcE8+TKkdOtGPhTw+xmZGt7TJd7ERs2fqSIBEmCp81ld
         fBlGr/eCjWhdF8pRCFM8ed0CEChGR+d26sZNH59MNtsZHTVUhbvPoozJ3Rh81YQEUze3
         OkYQ==
X-Forwarded-Encrypted: i=1; AL+hErGmf0rC+2KqzZ3s13dIdimv+PJ0tDbsq7qp4e1vtA8SZyzORmEunHubDOBm31hefZ9A6VtpH16gnA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/uxwesRBDUVP5SpKeXmEhICdD8GWoBdSXzfFmf+1Bfy9I22BHG
	g5hcM+YiFaoKhXboAVXakbq+FETyXbQqBltA0WBFPCFtNdQlLdHGTAURzdsjAWr3PzI=
X-Gm-Gg: AZFdTZdq84dG2Y0B4YBO1kDCVe5RWspUl+b7UPYeiOcjz9WMvKL59Bc83fhg9ppGgE+
	K9CMKbjJmbLlY5kBFZJDykIAQ2r+Zx6ZcoFPqXKNU/gLU7emWuohfIbnfNSP749vbIJwghNMJIa
	Sq+1iytrXZpPhMOb3+5ROpmDrRB7rvz+SZsbJtSkxry743f7PxK4Hd9BWFXKgOvfDt6dn+KkoSf
	5lO1eRKVcJ9jK2ch0C9+huymo4QqI3fvSjnKUTOuKH6z+bqrjUbPkjTPSA2p2aUPn/n9vZyyAFa
	A/HQTAk4ZicrAkPeAHgn5WkLGfCpWVBA8fknbutU1qhLJZ4C/WSboh1KCtRe0pzZQre+GXrhdkB
	Gcmhv5p88gv1DljAmAwqqaTMdNcnATcVJWsFNDm6QQqHBC5RxRHW9g6XW9sOjIq1kWNkde6eYCK
	G+M6dTkDMR0LBEuagcbNuCmfuckRXlTIXI5okZ8iHyRLF/lOtkhzSPEjUxNazlVkOF0VHEDoJ00
	dYuyMYlO7B7nqSgoavR3fGbj6jRFdscy/gLb+Qc5TSYmoVSKHIM3F5O7O9fpMbrmmwGqGpvfbMD
	2XTL1LOAc1pFkiwocLe7+xOO2/G640xI0OKA8JA7Adfn1d/whsmmdGP27og=
X-Received: by 2002:a05:6870:ed91:b0:49d:c9ed:21f2 with SMTP id 586e51a60fabf-4bc829918dbmr4393216fac.18.1795203768591;
        Fri, 20 Nov 2026 11:42:48 -0800 (PST)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5ebdc0acsm4159995fac.3.2026.11.20.11.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 11:42:47 -0800 (PST)
Message-ID: <62109a8b-7720-4e5b-afc5-1bf1560b7541@linuxfoundation.org>
Date: Fri, 20 Nov 2026 12:42:45 -0700
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
Subject: Re: [PATCH] cpupower: Initialize CPU lists before reading topology
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, trenn@suse.com
Cc: shuah@kernel.org, jwyatt@redhat.com, jkacur@redhat.com,
 linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20261120062130.98475-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261120062130.98475-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/26 23:21, Zhu Jun wrote:
> get_cpu_topology() allocates core_info without initializing its CPU list
> strings. If reading physical_package_id or core_id fails, the loop skips
> the CPU list read, but the later sort still passes that entry's string
> to strcmp(). A failed core_cpus_list read leaves the same problem.
> 
> Initialize each list to the existing "-1" sentinel before reading the
> topology attributes, so these failure paths always leave a terminated
> string for the sort and subsequent comparisons.

What happens without this patch? Are there any code paths that check this
value without first checking core and pkg fields?

> 
> Fixes: f89cb9cba7a2 ("cpupower: Implement CPU physical core querying")
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>   tools/power/cpupower/lib/cpupower.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/power/cpupower/lib/cpupower.c b/tools/power/cpupower/lib/cpupower.c
> index d7f7ec6f151c..010c279a7481 100644
> --- a/tools/power/cpupower/lib/cpupower.c
> +++ b/tools/power/cpupower/lib/cpupower.c
> @@ -178,6 +178,7 @@ int get_cpu_topology(struct cpupower_topology *cpu_top)
>   	for (cpu = 0; cpu < cpus; cpu++) {
>   		cpu_top->core_info[cpu].cpu = cpu;
>   		cpu_top->core_info[cpu].is_online = cpupower_is_cpu_online(cpu);
> +		strcpy(cpu_top->core_info[cpu].core_cpu_list, "-1");
>   		if(sysfs_topology_read_file(
>   			cpu,
>   			"physical_package_id",
> 
> 

thanks,
-- Shuah
