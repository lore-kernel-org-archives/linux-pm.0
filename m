Return-Path: <SRS0=f/N2=Z7=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9699C43603
	for <linux-pm@archiver.kernel.org>; Mon,  9 Dec 2019 09:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6392073D
	for <linux-pm@archiver.kernel.org>; Mon,  9 Dec 2019 09:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575883614;
	bh=ziRND3rXk9mCNGaNHcd4MdRZvXsIRNz9BwdJHsT2mkE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XOcFXgF96uUo9i1b8ly91KKGIozKB+ZmEXU2nDgSniEAvP8CNi0x5FOpOJTLf4+RZ
	 YSgoJlfLCamOZrmGqJfDH4Z7BRtEF9yOBR5TNrpw55DPp+KNcb2hS5QThsV174cB9y
	 ZRAywbhuMkLmEFubqM3hVWM5vivV3j0oO9S6rpWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfLIJ0y (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:26:54 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46263 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbfLIJ0x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 04:26:53 -0500
Received: by mail-oi1-f196.google.com with SMTP id a124so5665274oii.13
        for <linux-pm@vger.kernel.org>; Mon, 09 Dec 2019 01:26:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OpFhk3FMOcL7vwDTg3usn8yLh+6frAsJXkrfHjHDlx4=;
        b=NiD53afcRsHEA/o4y+1Sok9YftDeN6inCmI9Np/3y4j+FKR+Cx9ii+Fp9ArwbAcN62
         f3Qqwk0A7ghxEkD2FRvAXmieqEq2asn2abMW0YuppuvUftVBVWycKWYvb/dzej7nstXZ
         g+91mI+cVBrDlpUbTuhl9SVki50NjQ6KQTx3LDuLJvHpEdd/OrobdzLTQTN5KZ8CL01t
         cJUtIO+wPNeAxZ07Cw2l1EOBL8RgLorc45dDBdwh4Aj8VNH1SpJzCLDlDj+/OFB0+tk3
         flwzwPmXowqvOVbHzhs/pYiTnMRpYZgQPbdNjm/vPNx3kE6M2q4+5/Kh9RFx+k80NLNf
         muZQ==
X-Gm-Message-State: APjAAAX4eTgXZqAzuahc/4DSXnqkDSO9lfVXw/fgGRgYhKwzZfrJvHGk
        th7DS44slhZO3bS90YIF3t+o8vH+cIusJuqDKNI=
X-Google-Smtp-Source: APXvYqxIxjnf1GeWaJAKfAYQspvMbAypsK3NxvRYzEXLjAlIYmbyMNDfS8dPtXk35LCL+F1nBQxEoD2zKTrCaSGooOY=
X-Received: by 2002:a54:488d:: with SMTP id r13mr22201259oic.115.1575883612817;
 Mon, 09 Dec 2019 01:26:52 -0800 (PST)
MIME-Version: 1.0
References: <7b0313c4-0d2b-fbd9-469b-1e0ce79aacc3@linaro.org>
In-Reply-To: <7b0313c4-0d2b-fbd9-469b-1e0ce79aacc3@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 9 Dec 2019 10:26:41 +0100
Message-ID: <CAJZ5v0iXJz5yAbr_Dhk4k0FqGW6nhn2QF1oGf7Xi4Kfdvc83Wg@mail.gmail.com>
Subject: Re: cpuidle regression ?
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: multipart/mixed; boundary="000000000000f334ed059941fe3f"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--000000000000f334ed059941fe3f
Content-Type: text/plain; charset="UTF-8"

On Sun, Dec 8, 2019 at 11:40 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> the latest linux-next kernelci report indicates a kernel bug for the
> imx6 platform. I don't have this board so it is not possible to
> investigate it.
>
> https://storage.kernelci.org/next/master/next-20191208/arm/multi_v7_defconfig/gcc-8/lab-collabora/boot-imx6q-sabrelite.html
>
> [ ... ]
>
> [    3.372501] Unable to handle kernel NULL pointer dereference at
> virtual address 00000000
>
> [ ... ]
>
> [    3.408898] PC is at _find_first_bit_le+0xc/0x2c
> [    3.413785] LR is at cpuidle_driver_state_disabled+0x40/0xa0
>
>
> Not sure if it is related to the latest changes or not.

It does seem so, in which case the attached patch should address it.

Is there a way to test the patch alone or do I need to push it
somewhere to be tested?

--000000000000f334ed059941fe3f
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="cpuidle-fix-driver_state_disabled.patch"
Content-Disposition: attachment; 
	filename="cpuidle-fix-driver_state_disabled.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k3y8de9q0>
X-Attachment-Id: f_k3y8de9q0

LS0tCiBkcml2ZXJzL2NwdWlkbGUvZHJpdmVyLmMgfCAgIDEwICsrKysrKysrKysKIDEgZmlsZSBj
aGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspCgpJbmRleDogbGludXgtcG0vZHJpdmVycy9jcHVpZGxl
L2RyaXZlci5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LXBtLm9yaWcvZHJpdmVycy9jcHVpZGxlL2Ry
aXZlci5jCisrKyBsaW51eC1wbS9kcml2ZXJzL2NwdWlkbGUvZHJpdmVyLmMKQEAgLTQwMyw2ICs0
MDMsMTMgQEAgdm9pZCBjcHVpZGxlX2RyaXZlcl9zdGF0ZV9kaXNhYmxlZChzdHJ1YwogCiAJbXV0
ZXhfbG9jaygmY3B1aWRsZV9sb2NrKTsKIAorCXNwaW5fbG9jaygmY3B1aWRsZV9kcml2ZXJfbG9j
ayk7CisKKwlpZiAoIWRydi0+Y3B1bWFzaykgeworCQlkcnYtPnN0YXRlc1tpZHhdLmZsYWdzIHw9
IENQVUlETEVfRkxBR19VTlVTQUJMRTsKKwkJZ290byB1bmxvY2s7CisJfQorCiAJZm9yX2VhY2hf
Y3B1KGNwdSwgZHJ2LT5jcHVtYXNrKSB7CiAJCXN0cnVjdCBjcHVpZGxlX2RldmljZSAqZGV2ID0g
cGVyX2NwdShjcHVpZGxlX2RldmljZXMsIGNwdSk7CiAKQEAgLTQxNSw1ICs0MjIsOCBAQCB2b2lk
IGNwdWlkbGVfZHJpdmVyX3N0YXRlX2Rpc2FibGVkKHN0cnVjCiAJCQlkZXYtPnN0YXRlc191c2Fn
ZVtpZHhdLmRpc2FibGUgJj0gfkNQVUlETEVfU1RBVEVfRElTQUJMRURfQllfRFJJVkVSOwogCX0K
IAordW5sb2NrOgorCXNwaW5fdW5sb2NrKCZjcHVpZGxlX2RyaXZlcl9sb2NrKTsKKwogCW11dGV4
X3VubG9jaygmY3B1aWRsZV9sb2NrKTsKIH0K
--000000000000f334ed059941fe3f--
