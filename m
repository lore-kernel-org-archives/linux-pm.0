From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH 0/3] idle, Honor Hardware Disabled States
Date: Tue, 03 May 2016 14:11:56 -0400
Message-ID: <5728E9EC.4030801@redhat.com>
References: <1458564569-19672-1-git-send-email-prarit@redhat.com>	<CAJvTdKk0qsFsN7RPQGVQ7mWbd2N9jW7kZbH4htSnMBxvwo8M2w@mail.gmail.com>	<56F32BDB.1010107@redhat.com>	<CAJvTdKmi2pfE+fn5-MVd8T5_0j+EbASJ992AYmVKG2osk762yQ@mail.gmail.com>	<56F94439.3000908@redhat.com>	<CAJvTdKmmoZFJ83dx6vS6D8FasrHKdgpxMEC_rVM-_6tZe2s6dg@mail.gmail.com>	<570B8C7E.2030504@redhat.com> <CAJvTdK=tuqYo_YaOFCTZZbF9VWGo1CjqXSavod4LKb3vNfBS2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55204 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933513AbcECSL7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 3 May 2016 14:11:59 -0400
In-Reply-To: <CAJvTdK=tuqYo_YaOFCTZZbF9VWGo1CjqXSavod4LKb3vNfBS2w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Borislav Petkov <bp@suse.de>, Andi Kleen <ak@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>, Linux PM list <linux-pm@vger.kernel.org>



On 04/29/2016 05:36 AM, Len Brown wrote:

> But above is all cosmetic.  The real "bug" that users are running into is
> that they can't get into deep c-states when they are enabled.
> Linux (and Intel) need to do a much better job enabling diagnosis of
> that condition.
> 
Okay, I geddit.

Acked-by: Prarit Bhargava <prarit@redhat.com>

P.
