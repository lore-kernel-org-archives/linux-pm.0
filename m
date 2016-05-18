From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] powercap/rapl: Do not load in virtualized environments
Date: Wed, 18 May 2016 05:59:53 -0400
Message-ID: <573C3D19.8060400@redhat.com>
References: <1463484845-9839-1-git-send-email-prarit@redhat.com> <CAJZ5v0g59CvQVePgCbEsXvw5UqOcqvn-Snh3=0Jcnj=mhT_mfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35775 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753049AbcERJ7z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 18 May 2016 05:59:55 -0400
In-Reply-To: <CAJZ5v0g59CvQVePgCbEsXvw5UqOcqvn-Snh3=0Jcnj=mhT_mfg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jacob Jun Pan <jacob.jun.pan@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>



On 05/17/2016 08:50 PM, Rafael J. Wysocki wrote:
> On Tue, May 17, 2016 at 1:34 PM, Prarit Bhargava <prarit@redhat.com> wrote:
>> intel_rapl is currently not supported in virtualized environments.  When
>> booting the warning message
>>
>> intel_rapl: no valid rapl domains found in package 0
> 
> You seem to be saying that this message is problematic for some
> reason, so why is it?

It is a loud warning message that comes up for every cpu.  The virt boot is
essentially silent *except* for the above messages.

P.
