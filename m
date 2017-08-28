From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PULL REQUEST] for Rafael's Linux-PM / For-Next
Date: Tue, 29 Aug 2017 00:28:59 +0200
Message-ID: <CAJZ5v0ihY1Xa=d4quSfDaFO9f=JNGUbMQ+5gdS-AG91+b8HBcg@mail.gmail.com>
References: <CGME20170828025652epcms1p26fcf887eb41cf3a620b0ef40baa9eb5b@epcms1p2>
 <20170828025652epcms1p26fcf887eb41cf3a620b0ef40baa9eb5b@epcms1p2>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:36102 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbdH1W3A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2017 18:29:00 -0400
Received: by mail-oi0-f50.google.com with SMTP id t75so14937910oie.3
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2017 15:29:00 -0700 (PDT)
In-Reply-To: <20170828025652epcms1p26fcf887eb41cf3a620b0ef40baa9eb5b@epcms1p2>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Myungjoo Ham <myungjoo.ham@samsung.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>, "robh@kernel.org" <robh@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "myungjoo.ham@gmail.com" <myungjoo.ham@gmail.com>

Hi,

On Mon, Aug 28, 2017 at 4:56 AM, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
> Dear Rafael,
>
> Here goes a pull request from PM/devfreq with trivial fixes
> - printk formatting error
> - move private function from shared header to priviate header
> - add dependency (Kconfig) on OPP as it becomes mandatory (OPP being widely adopted)
> - fix memory leak

Pulled, thanks!
