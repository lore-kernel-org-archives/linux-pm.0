From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [PATCH 1/2] PM / Runtime: Add sysfs switch
 for	disabling device run-time PM (rev. 2)
Date: Fri, 05 Feb 2010 19:03:20 +1100
Message-ID: <4B6BD0C8.5020400__38202.7739346542$1265364493$gmane$org@crca.org.au>
References: <201001180129.55219.rjw@sisk.pl>
	<201001212357.46483.rjw@sisk.pl>	<201001212359.38886.rjw@sisk.pl>
	<20100204224623.GB1436@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100204224623.GB1436@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg KH <greg@kroah.com>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

Hi Pavel et al.

Pavel Machek wrote:
> Hi!
> 
>>  /*
>> + *	control - Report/change current runtime PM setting of the device
>> + *
>> + *	Runtime power management of a device can be blocked with the help of
>> + *	this attribute.  All devices have one of the following two values for
>> + *	the power/control file:
>> + *
>> + *	 + "auto\n" to allow the device to be power managed at run time;
>> + *	 + "on\n" to prevent the device from being power managed at run time;
> 
> I find interface with mandatory \n quite 'interesting'. 

Agreed.

> Plus english is strange here. All devices have ... "auto" to allow...?
> Strange formulation. List the values first, then add "write ... to allow"?

It seems okay to me because of the preceding sentence ending in a colon.

Regards,

Nigel
