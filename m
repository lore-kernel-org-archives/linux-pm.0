From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 1/3] mm: add kstrdup_trimnl function
Date: Wed, 5 Feb 2014 13:50:52 -0800
Message-ID: <20140205135052.4066b67689cbf47c551d30a9@linux-foundation.org>
References: <1391546631-7715-1-git-send-email-sebastian.capella@linaro.org>
	<1391546631-7715-2-git-send-email-sebastian.capella@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:38477 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbaBEVuy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Feb 2014 16:50:54 -0500
In-Reply-To: <1391546631-7715-2-git-send-email-sebastian.capella@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Capella <sebastian.capella@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, Michel Lespinasse <walken@google.com>, Shaohua Li <shli@kernel.org>, Jerome Marchand <jmarchan@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Joe Perches <joe@perches.com>, David Rientjes <rientjes@google.com>, Alexey Dobriyan <adobriyan@gmail.com>

On Tue,  4 Feb 2014 12:43:49 -0800 Sebastian Capella <sebastian.capella@linaro.org> wrote:

> kstrdup_trimnl creates a duplicate of the passed in
> null-terminated string.  If a trailing newline is found, it
> is removed before duplicating.  This is useful for strings
> coming from sysfs that often include trailing whitespace due to
> user input.

hm, why?  I doubt if any caller of this wants to retain leading and/or
trailing spaces and/or tabs.

