From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] power: qos: Export pm_qos_update_request_timeout()
Date: Wed, 6 Dec 2017 17:43:45 +0100
Message-ID: <CAJZ5v0jHDDYhag2s8FyrUJ9G5qCu9c94dRBfPKqxEvmfvKFKbQ@mail.gmail.com>
References: <1512470739-21960-1-git-send-email-hareeshg@codeaurora.org>
 <CAJZ5v0hwFo2hake52oGqrLt09ivfNCmw8pJY6uwqXVQ97FchkA@mail.gmail.com> <38aa8cac-3e7b-8406-a8d0-ee13b35d4811@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34636 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751941AbdLFQnq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Dec 2017 11:43:46 -0500
Received: by mail-oi0-f67.google.com with SMTP id u193so2963134oie.1
        for <linux-pm@vger.kernel.org>; Wed, 06 Dec 2017 08:43:46 -0800 (PST)
In-Reply-To: <38aa8cac-3e7b-8406-a8d0-ee13b35d4811@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hareesh Gundu <hareeshg@codeaurora.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, jcrouse@codeaurora.org, Linux PM <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Wed, Dec 6, 2017 at 4:35 PM, Hareesh Gundu <hareeshg@codeaurora.org> wrote:
>
> On 12/5/2017 8:54 PM, Rafael J. Wysocki wrote:
>>
>> On Tue, Dec 5, 2017 at 11:45 AM, Hareesh Gundu <hareeshg@codeaurora.org>
>> wrote:
>>>
>>> Add EXPORT_SYMBOL_GPL to pm_qos_update_request_timeout,
>>> so that it can be usable from modules similar to the
>>> pm_qos_update_request().
>>>
>>> Signed-off-by: Hareesh Gundu <hareeshg@codeaurora.org>
>
> There is no in-tree kernel module using it. It's required for modules built
> out-tree kernel.
> Does it really required show out tree kernel module uses this symbol ?

If the module is out of the tree, the patch can be out of the tree
too, unless there is a very good reason for it to be in the tree.

So, what is that reason?
