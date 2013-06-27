From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] ARM: cpuidle: davinci: Fix target residency
Date: Thu, 27 Jun 2013 18:47:56 +0400
Message-ID: <51CC509C.6040804@cogentembedded.com>
References: <1372327012-13528-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:51508 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746Ab3F0Or4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2013 10:47:56 -0400
Received: by mail-la0-f53.google.com with SMTP id fs12so926402lab.40
        for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2013 07:47:55 -0700 (PDT)
In-Reply-To: <1372327012-13528-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: nsekhar@ti.com, khilman@deeprootsystems.com, rjw@sisk.pl, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

Hello.

On 27-06-2013 13:56, Daniel Lezcano wrote:

> The commit 19976c2a88d125aec16b9255c7197c297bbdd637 changed the target

    Please also specify the summary line of that commit in parens.

> residency to 100000, assuming this is a careless mistake.

> The same happened to the at91's cpuidle driver.

> Fix it by putting the initial value to 10000.

> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

WBR, Sergei

