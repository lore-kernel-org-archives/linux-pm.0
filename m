From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH RFC v1 2/3] Fix hibernation restore hang in freeze_processes
Date: Mon, 24 Feb 2014 15:09:38 +0800
Message-ID: <CACVXFVMN_uijYRj9CCKHbnM40YVyp8ar7mp4g=s70gv8YmFCLA@mail.gmail.com>
References: <1392774729-3235-1-git-send-email-sebastian.capella@linaro.org>
	<1392774729-3235-3-git-send-email-sebastian.capella@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:35398 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbaBXHJl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2014 02:09:41 -0500
In-Reply-To: <1392774729-3235-3-git-send-email-sebastian.capella@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Capella <sebastian.capella@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM List <linux-pm@vger.kernel.org>, linaro-kernel@lists.linaro.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russ Dill <Russ.Dill@ti.com>

On Wed, Feb 19, 2014 at 9:52 AM, Sebastian Capella
<sebastian.capella@linaro.org> wrote:
> During restore, pm_notifier chain are called with
> PM_RESTORE_PREPARE.  The firmware_class driver handler
> fw_pm_notify does not have a handler for this.  As a result,
> it keeps a reader on the kmod.c umhelper_sem.  During
> freeze_processes, the call to __usermodehelper_disable tries to
> take a write lock on this semaphore and hangs waiting.
>
> Signed-off-by: Sebastian Capella <sebastian.capella@linaro.org>
> Cc: Russ Dill <Russ.Dill@ti.com>
> Cc: Ming Lei <ming.lei@canonical.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Ming Lei <ming.lei@canonical.com>

Thanks,
--
Ming Lei
