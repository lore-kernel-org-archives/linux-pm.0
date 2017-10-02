From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v4 24/27] x86_32: assembly, add ENDs to some functions and
 relabel with SYM_CODE_*
Date: Mon, 2 Oct 2017 14:16:54 -0400
Message-ID: <30e503c9-b7cf-42ca-e1c9-cc36c6f59f69@oracle.com>
References: <20171002091246.28432-1-jslaby@suse.cz>
 <20171002091246.28432-24-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:39907 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751922AbdJBSRp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Oct 2017 14:17:45 -0400
In-Reply-To: <20171002091246.28432-24-jslaby@suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>, mingo@redhat.com
Cc: tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Juergen Gross <jgross@suse.com>, linux-pm@vger.kernel.org, xen-devel@lists.xenproject.org

On 10/02/2017 05:12 AM, Jiri Slaby wrote:
> All these are functions which are invoked from elsewhere, but they are
> not typical C functions. So we annotate them (as global) using the new
> SYM_CODE_START. All these were not balanced with any END, so mark their
> ends by SYM_CODE_END, appropriatelly.
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: linux-pm@vger.kernel.org
> Cc: xen-devel@lists.xenproject.org

For Xen bits:

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
