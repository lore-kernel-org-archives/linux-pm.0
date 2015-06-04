From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/1] x86 TSC: set X86_FEATURE_TSC_RELIABLE, per CPUID
Date: Thu, 04 Jun 2015 00:17:21 -0700
Message-ID: <556FFB81.8080507@zytor.com>
References: <f1643565587e70dd2fe2714e9afa566689211a9a.1433050960.git.len.brown@intel.com>	<556CA704.1070000@kernel.org> <CAJvTdKm8mksFNnhchXepOanjCT4qiYTjmt3BtL81BepuPw+K1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:43096 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751577AbbFDHR3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 4 Jun 2015 03:17:29 -0400
In-Reply-To: <CAJvTdKm8mksFNnhchXepOanjCT4qiYTjmt3BtL81BepuPw+K1w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Andy Lutomirski <luto@kernel.org>
Cc: X86 ML <x86@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On 06/01/2015 05:45 PM, Len Brown wrote:
> 
> BTW, it also begs the question if Linux could actually *repair* the BIOS damage?
> 

We may very well be able to by setting the TSC offset register to zero
on all CPUs.

	-hpa


