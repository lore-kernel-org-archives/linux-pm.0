From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 0/4] treewide: Fix line continuation formats
Date: Thu, 16 Nov 2017 09:17:29 -0800
Message-ID: <1510852649.31559.38.camel@perches.com>
References: <cover.1510845910.git.joe@perches.com>
         <1510852273.3711.448.camel@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay0208.hostedemail.com ([216.40.44.208]:47322 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935082AbdKPRRe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Nov 2017 12:17:34 -0500
In-Reply-To: <1510852273.3711.448.camel@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mimi Zohar <zohar@linux.vnet.ibm.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org, linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, linux-security-module@vger.kernel.org

On Thu, 2017-11-16 at 12:11 -0500, Mimi Zohar wrote:
> On Thu, 2017-11-16 at 07:27 -0800, Joe Perches wrote:
> > Avoid using line continations in formats as that causes unexpected
> > output.
> 
> Is having lines greater than 80 characters the preferred method?

yes.

>  Could you add quotes before the backlash and before the first word on
> the next line instead?

coalesced formats are preferred.
