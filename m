From: Daniel Drake <dsd@gentoo.org>
Subject: Re: usb_id segfaulting on 2.6.23
Date: Tue, 06 Nov 2007 17:54:14 +0000
Message-ID: <4730AA46.6000102__9744.47402772984$1194371864$gmane$org@gentoo.org>
References: <Pine.LNX.4.44L0.0711061108220.3883-100000@iolanthe.rowland.org>
	<4730A99A.3010809@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4730A99A.3010809@gentoo.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oneukum@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, linux-hotplug-devel@lists.sourceforge.net, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Daniel Drake wrote:
> Alan Stern wrote:
>> Ah, okay.  This is a known problem, a configuration-related issue.  
>> The PM core doesn't create a device's /sys/.../power subdirectory
>> unless CONFIG_PM_SLEEP is set.  In fact it should be created whenever
>> CONFIG_PM is set.
>>
>> I haven't had time to write a patch for this yet.  Do you want to try?
> 
> OK. Any comments on this before I sent it to the proper channels?

Missed a hunk where I remove the existing dpm_sysfs_add() call from 
drivers/base/power/main.c but you get the idea.. although I'm 
increasingly unsure if this is the right approach.

Daniel
