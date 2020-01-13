Return-Path: <SRS0=HpL5=3C=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD82C33C9A
	for <linux-pm@archiver.kernel.org>; Mon, 13 Jan 2020 10:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1AB52084D
	for <linux-pm@archiver.kernel.org>; Mon, 13 Jan 2020 10:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578909700;
	bh=NK0UGTfPKqpkCkm221GzQdzg8zupU25GsEb0NnPTvUc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=n3J7+4Z5uh9N1PFEj5TwDb68jB+HI0+SplpewU95+J8ZkccXw7SRyMtD5Sph3VTpv
	 Pst77EXX4wZ7ctK7vVGYlqBIeNiOxcyvNeLvb2ol3U1dKJWH7fy1UxQyjys0wZyv2/
	 kW9SST5ZlAiU0399QJifu5M00gneoBnNL99Zt5gY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgAMKBk (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 13 Jan 2020 05:01:40 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43806 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgAMKBk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 05:01:40 -0500
Received: by mail-oi1-f195.google.com with SMTP id p125so7654060oif.10;
        Mon, 13 Jan 2020 02:01:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZxfV/19Ef7tFibMeoIeo9F/UijjdOkO2LaetF4dIIo0=;
        b=qrJ8ErRecFBrZNDQt5zpAywuMnx+r7RwWrdrZYIB3gd7nXLRmVhPXrlxUGAVg8MRpn
         KsV2vgwV9cBjl+Zblx01A2ks7My5BeEj45MgCC70gAIhTxoNgdjmZp3pj8dbRT2dlNSW
         h5UL0SFg1dxjgE2+8fkCOp/7je/A4Y1ghuoa7+QJYZ7Q+o6Ii9KtFG9tJsTl0kEfY6Sx
         QQC6Dp9PeMnUnsXdEK5PHz7uaupbM9VBoeR5UbPWSn3INkBL4cKq+MRmKondEDcck9U8
         /qwuUC1KO5OIzdjBj+aE4CFw6wJW8GkszZ3Ng6POI6BRGnhzhKIArZzkSK5s0jqevFXO
         AMvg==
X-Gm-Message-State: APjAAAWxs2IDVChzDNR9UCkgVVKCvpqOYdvv5DYixXJ9HlUlGI1MM8qM
        3go6VyYA+aYCzpZGjrNUT8zV0jsrRXtE9LakRD3eOw==
X-Google-Smtp-Source: APXvYqx5ZelIAVdutcTucnolspYO4WcppcqO3Ff2Re+R9IogvrNCiCfqsVFFkZKXph7HvHLiXpiXTkCA3XZ1IZ51i2A=
X-Received: by 2002:a54:4e96:: with SMTP id c22mr12444869oiy.110.1578909699188;
 Mon, 13 Jan 2020 02:01:39 -0800 (PST)
MIME-Version: 1.0
References: <20200113060724.19571-1-yu.c.chen@intel.com>
In-Reply-To: <20200113060724.19571-1-yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Jan 2020 11:01:28 +0100
Message-ID: <CAJZ5v0jgdfAG_BDefdSQFV9hM61o68Aj31PxShNxxcpsYFpxgw@mail.gmail.com>
Subject: Re: [PATCH] PCI/PM: Print the pci config space of devices before suspend
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 13, 2020 at 7:08 AM Chen Yu <yu.c.chen@intel.com> wrote:
>
> The pci config space was found to be insane during resume

I wouldn't call it "insane".

It probably means that the device was not present or not accessible
during hibernation and now it appears to be present (maybe the restore
kernel found it and configured it).

> from hibernation(S4, or suspend to disk) on a VM:
>
>  serial 0000:00:16.3: restoring config space at offset 0x14
>  (was 0x9104e000, writing 0xffffffff)
>
> Either the snapshot on the disk has been scribbled or the pci
> config space becomes invalid before suspend.

Or, most likely, the above.

> To narrow down and benefit future debugging, print the pci config space
> being saved before suspend, which is symmetric to the log
> in pci_restore_config_dword().

But the code change makes sense to me.

> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  drivers/pci/pci.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e87196cc1a7f..34cde70440c3 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1372,8 +1372,11 @@ int pci_save_state(struct pci_dev *dev)
>  {
>         int i;
>         /* XXX: 100% dword access ok here? */
> -       for (i = 0; i < 16; i++)
> +       for (i = 0; i < 16; i++) {
>                 pci_read_config_dword(dev, i * 4, &dev->saved_config_space[i]);
> +               pci_dbg(dev, "saving config space at offset %#x (reading %#x)\n",
> +                       i * 4, dev->saved_config_space[i]);
> +       }
>         dev->state_saved = true;
>
>         i = pci_save_pcie_state(dev);
> --
> 2.17.1
>
