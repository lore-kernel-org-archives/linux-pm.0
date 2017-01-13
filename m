From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 2/5] powernv:stop: Uniformly rename power9 to arch300
Date: Fri, 13 Jan 2017 09:14:18 +0530
Message-ID: <20170113034418.GA10844@in.ibm.com>
References: <1484039224-5630-1-git-send-email-ego@linux.vnet.ibm.com>
 <1484039224-5630-3-git-send-email-ego@linux.vnet.ibm.com>
 <20170112094733.GC3006@localhost.localdomain>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170112094733.GC3006@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Balbir Singh <bsingharora@gmail.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Michael Neuling <mikey@neuling.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, "Shreyas B. Prabhu" <shreyasbp@gmail.com>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Stewart Smith <stewart@linux.vnet.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, mark.rutland@arm.com
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 12, 2017 at 03:17:33PM +0530, Balbir Singh wrote:
> On Tue, Jan 10, 2017 at 02:37:01PM +0530, Gautham R. Shenoy wrote:
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > 
> > Balbir pointed out that in idle_book3s.S and powernv/idle.c some
> > functions and variables had power9 in their names while some others
> > had arch300.
> >
> 
> I would prefer power9 to arch300
>


I don't have a strong preference for arch300 vs power9, will change it
to power9 if that looks better.

--
Thanks and Regards
gautham.
