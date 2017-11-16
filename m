From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/4] treewide: Fix line continuation formats
Date: Thu, 16 Nov 2017 14:35:22 -0500
Message-ID: <1510860922.3711.452.camel@linux.vnet.ibm.com>
References: <cover.1510845910.git.joe@perches.com>
         <1510852273.3711.448.camel@linux.vnet.ibm.com>
         <1510852649.31559.38.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-security-module-owner@vger.kernel.org>
In-Reply-To: <1510852649.31559.38.camel@perches.com>
Sender: owner-linux-security-module@vger.kernel.org
To: Joe Perches <joe@perches.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org, linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, linux-security-module@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2017-11-16 at 09:17 -0800, Joe Perches wrote:
> On Thu, 2017-11-16 at 12:11 -0500, Mimi Zohar wrote:
> > On Thu, 2017-11-16 at 07:27 -0800, Joe Perches wrote:
> > > Avoid using line continations in formats as that causes unexpected
> > > output.
> > 
> > Is having lines greater than 80 characters the preferred method?
> 
> yes.
> 
> >  Could you add quotes before the backlash and before the first word on
> > the next line instead?
> 
> coalesced formats are preferred.

In the future, please reference the commit 6f76b6fcaa60 "CodingStyle:
Document the exception of not splitting user-visible strings, for
grepping"

thanks,

Mimi

