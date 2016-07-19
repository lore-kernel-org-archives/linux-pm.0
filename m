From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/1] PCI / PM: check all fields in pci_set_platform_pm()
Date: Wed, 20 Jul 2016 00:04:19 +0200
Message-ID: <CAJZ5v0heN60WdN3QWCg85nUq+Rv8QGRMMNbq6ZvWWPf0By-xPA@mail.gmail.com>
References: <1465223133-73532-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20160719213751.GA18635@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35322 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbcGSWEV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jul 2016 18:04:21 -0400
In-Reply-To: <20160719213751.GA18635@localhost>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>

On Tue, Jul 19, 2016 at 11:37 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Mon, Jun 06, 2016 at 05:25:33PM +0300, Andy Shevchenko wrote:
>> When assign new PCI platform PM operations check for all mandatory fields to
>> prevent NULL pointer dereference.
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>  drivers/pci/pci.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index c8b4dbd..badbddc 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -530,8 +530,8 @@ static const struct pci_platform_pm_ops *pci_platform_pm;
>>
>>  int pci_set_platform_pm(const struct pci_platform_pm_ops *ops)
>>  {
>> -     if (!ops->is_manageable || !ops->set_state || !ops->choose_state
>> -         || !ops->sleep_wake)
>> +     if (!ops->is_manageable || !ops->set_state || !ops->choose_state ||
>> +         !ops->sleep_wake || !ops->run_wake || !ops->need_resume)
>>               return -EINVAL;
>
> This looks OK to me.  platform_pci_run_wake() and
> platform_pci_need_resume() assume that if pci_platform_pm is set,
> pci_platform_pm->run_wake and pci_platform_pm->need_resume are valid
> function pointers.  This is analogous to what we already do for
> ops->is_manageable, etc.
>
> Rafael, do you want to take this or should I?
>
>>       pci_platform_pm = ops;
>>       return 0;
>> --

I can take it.

Thanks,
Rafael
