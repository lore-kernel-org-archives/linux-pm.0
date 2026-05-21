Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53F618A92F
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 08:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352340; cv=none; b=nATPKLSmmSMSlt5GWRgFcC7nailtzrUacY/LS1kq/d/mjNQZ3sVZabBzfd7SWTKivggRo9qNqy4aZR3cMBznAnpxttS95zR7OB0zojzJq2wCpqGkqItu4pJJXieFUdZdzgUo1kJbXHDLlkqdx+UztvxJlvuBSkNKiu2axugVsfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352340; c=relaxed/simple;
	bh=mCZi86GgXfa281taEnSFOsVmo3QgGXvuSXU409tirrg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mAEiOHnd6Pp/w8KEWW+BRYQGpitN5bUd9hmdePD1pBk6Oo5ncyrb1eLJVOV/CuKqubegyZbXRgTPvBfD2sygvngdFahcTY7T7KdUmjOSKwJDv4koJOcnUnz5bKotEAGy1jvTitTuZ4AxdV8ypnJls/6zGh2TE95aFoLoQfMLmMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnZfiTSF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnZfiTSF"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso51360065e9.2
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 01:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779352337; x=1779957137; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hkPRO/w3Xwll7Bz4lSDFV9OPO7WZ1/PTH41L8qr9LZQ=;
        b=UnZfiTSF+DMV6b7kfAEjKGwVhdI4vRWEKdXjfynzsNvEGDQLJsr/lN4FM8aQcpBb/Y
         6Ka0oVqZLO6uIfDKMGT51PGKA3C/DJmouB+egCQzRld5w1HLRbGmMSr9zGtpY8nmFK/D
         bgQsD/r1KTAV7xq8sSrWeZHX8ueaszIqT+JVgeB4qeYTY+zklIuMSChavG1U+QvJMLt2
         hKHwdku6xeYs8x8x4R3dWZsIBT6eF9S8utAHVfGfPPT7DPKxnMNxLcjqWhUybT8mDOJU
         4KN3viwgMqgg6qCI+Lf5RBKAKmoXY4EDxVPbUp8orO85hipGj8e0/Umrj6BApA6d6GXN
         fiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352337; x=1779957137;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hkPRO/w3Xwll7Bz4lSDFV9OPO7WZ1/PTH41L8qr9LZQ=;
        b=oWgbcasMsUZaMo2B2WHbCLmEjyCsmh2pWZjkzoOoGv+oe0QtEC2eOnuTrxvie+uJnL
         lTUV9MxJO9s7eG0UP2jSWAfz7Qq0DZheeUEURARWS5S/c+e9T2CNPvvPVrgmLXz4Z/w8
         ldtUK7HiYNEY28U6awCWDkVhaB4jYPnc0UxZpznjEo3Mt1zpZJlANIQrjyJ0k86nhQg+
         29sVHUbN6YqAkaXJPkt/2d6eYYjlZ8/oqJ4QKj144GNMFN0gBLN0tMa3qgxbJDBQvhAY
         TSGwuugmVVinjJ/5WsB5OoA8J4wu9H8UviQd3J9C3quVg4l9/lG8559Qwd++EoAOpsxo
         mV3w==
X-Gm-Message-State: AOJu0YzxdML+OMQE/Ypzi384uR12rcYV2DRvSn0jZ/4PF+FRFNs5FBAN
	lcW1Ao40vPXtCuTiJxO9QYucpczB5dFhwW4DJtn1CaueroUYag8GUj8mGeS0Jg==
X-Gm-Gg: Acq92OEhVkfilToooTgHiEWoJpbqyOpeQUucbszvfZQ4A8o6uGZtI9AlqnNVYac5qlj
	8JqTvhMeXPSw2PxcySLPojqPzMrTXuZoaS+8HtZ1hyXRxIAvqJ7mEDNEfLZAWcyR8fTO07OXwZF
	xMiiavfff8pnvaU0sDn2Q+Fno03L02sa338BjExan7YUvg+NgCiDNpjai5p+5Jgh8eZg1GNLAhm
	2FEUbzXrRwFF28nnXVfmdVGizN1V90Xs26mUKJRAvd7WuPswYZ0fM6NHPI1xEU2ubRPLxRbfWZB
	eL479oZyA3Qoeo+edph9lRBPLii/u+8wYWka+eKo+JVPuauIewKGdvor1wcxA/6fPlJfTDGv3qS
	J4Juhh5MmC3xIPUuanLvUNUNdy3u4uYLkXpyHRMgBIraP03UgxrL+a9PvkVhnDFnUisHyPtMc5b
	9GL+Qr0LfERwyfDs4vU6nQCJo=
X-Received: by 2002:a05:600c:41d3:b0:48f:e6de:1cb9 with SMTP id 5b1f17b1804b1-4903608931bmr15205625e9.19.1779352337032;
        Thu, 21 May 2026 01:32:17 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903cae778asm8099675e9.13.2026.05.21.01.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:32:16 -0700 (PDT)
Date: Thu, 21 May 2026 11:32:13 +0300
From: Dan Carpenter <error27@gmail.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: linux-pm@vger.kernel.org
Subject: [bug report] firmware: scpi: add device power domain support using
 genpd
Message-ID: <ag7DDZf3TFZy_o3e@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Sudeep Holla,

Commit 8bec4337ad40 ("firmware: scpi: add device power domain support
using genpd") from Jun 2, 2016 (linux-next), leads to the following
Smatch static checker warning:

	drivers/pmdomain/marvell/pxa1908-power-controller.c:231 pxa1908_pd_init()
	warn: passing positive error code '1' to 'dev_err_probe'

drivers/pmdomain/marvell/pxa1908-power-controller.c
    216 static int
    217 pxa1908_pd_init(struct pxa1908_pd_ctrl *ctrl, int id, struct device *dev)
    218 {
    219         struct pxa1908_pd *pd = &domains[id];
    220         int ret;
    221 
    222         ctrl->domains[id] = &pd->genpd;
    223 
    224         pd->ctrl = ctrl;
    225 
    226         /* Make sure the state of the hardware is synced with the domain table above. */
    227         if (pd->data.keep_on) {
    228                 ret = pd->genpd.power_on(&pd->genpd);
    229                 if (ret)
    230                         return dev_err_probe(dev, ret, "failed to power on domain '%s'\n",
--> 231                                              pd->genpd.name);
    232         } else {

The problem is that genpd.power_on() functions are supposed to return
0 on success or negative error codes.

drivers/pmdomain/arm/scpi_pm_domain.c
    34  static int scpi_pd_power(struct scpi_pm_domain *pd, bool power_on)
    35  {
    36          int ret;
    37          enum scpi_power_domain_state state;
    38  
    39          if (power_on)
    40                  state = SCPI_PD_STATE_ON;
    41          else
    42                  state = SCPI_PD_STATE_OFF;
    43  
    44          ret = pd->ops->device_set_power_state(pd->domain, state);
    45          if (ret)
    46                  return ret;
                        ^^^^^^^^^^^
Negatives.  Good.

    47  
    48          return !(state == pd->ops->device_get_power_state(pd->domain));
                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
But this returns 0/1.

    49  }
    50  
    51  static int scpi_pd_power_on(struct generic_pm_domain *domain)
    52  {
    53          struct scpi_pm_domain *pd = to_scpi_pd(domain);
    54  
    55          return scpi_pd_power(pd, true);
    56  }
    57  
    58  static int scpi_pd_power_off(struct generic_pm_domain *domain)
    59  {
    60          struct scpi_pm_domain *pd = to_scpi_pd(domain);
    61  
    62          return scpi_pd_power(pd, false);
    63  }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
