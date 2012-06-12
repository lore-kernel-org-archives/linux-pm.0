From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: Re: [RFC] [PATCH 1/4] thermal: Use thermal zone device
 id in netlink messages
Date: Tue, 12 Jun 2012 17:02:39 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB59136298@BGSMSX101.gar.corp.intel.com>
References: <1339507519-14434-1-git-send-email-eduardo.valentin@ti.com>
	<1339507519-14434-2-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1339507519-14434-2-git-send-email-eduardo.valentin@ti.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Eduardo Valentin <eduardo.valentin@ti.com>, "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Eduardo,

> 
> This patch changes the function thermal_generate_netlink_event
> to receive a thermal zone device instead of a originator id.
> 
> This way, the messages will always be bound to a thermal zone.

I agree with you on this patch implementation.

But I am thinking most user space Apps today are using UEvent based
mechanism, may be it is time for us to re-visit this implemention.
There are standard UEvent parsers available which can be used.
(instead of writing custom netlink parsing implementations)

I submitted this patch an year ago, (inspired by some acpi driver,
which uses this same netlink mechanism) and have a couple of
platforms using this. I can change them for my side.

I don't know what other platforms are using this. Need Rui's
help/suggestion here.

Thanks,
Durga
