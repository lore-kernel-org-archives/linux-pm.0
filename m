From: Colin Cross <ccross@android.com>
Subject: Re: [PATCH 07/10] futex: use freezable blocking call
Date: Mon, 29 Apr 2013 16:46:15 -0700
Message-ID: <CAMbhsRRb3s_r7i2id-nZHS5koxe-X+86qVGeYtoBqLWQdR0=iQ@mail.gmail.com>
References: <1367271946-7239-1-git-send-email-ccross@android.com>
	<1367271946-7239-8-git-send-email-ccross@android.com>
	<517EF9AB.8080508@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vb0-f54.google.com ([209.85.212.54]:62369 "EHLO
	mail-vb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932638Ab3D2XqR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2013 19:46:17 -0400
Received: by mail-vb0-f54.google.com with SMTP id w16so5641750vbf.41
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2013 16:46:16 -0700 (PDT)
In-Reply-To: <517EF9AB.8080508@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Darren Hart <dvhart@linux.intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Matthew Helsley <matthltc@us.ibm.com>

On Mon, Apr 29, 2013 at 3:52 PM, Darren Hart <dvhart@linux.intel.com> wrote:
> Colin,
>
> I don't know anything about when or when not to use freezable*, and I
> suspect that may be true for others as well. A more complete
> description of why it's acceptable here in the commit log might help
> expedite acceptance.
>

Sure, how about:
This call can be converted to a freezable call because it doesn't hold
any locks or release any resources when interrupted that might be
needed by another freezing task or a kernel driver during suspend.
