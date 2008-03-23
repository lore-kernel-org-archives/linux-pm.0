From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and
	hibernation callbacks (rev. 2)
Date: Sun, 23 Mar 2008 22:16:43 +0100
Message-ID: <200803232216.44627.rjw__49758.3782104359$1206307162$gmane$org@sisk.pl>
References: <200803210101.04706.rjw@sisk.pl>
	<20080321081536.GA25009@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080321081536.GA25009@uranus.ravnborg.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Friday, 21 of March 2008, Sam Ravnborg wrote:
> Hi Rafael.

Hi Sam,

> Is it possible to extend this in some way so we avoid the
> #ifdef stuff in the drivers?

Well, I'd love to do something like this.

> We could introduce a few special sections that we discard if
> PM is not in use.
> We have a reliable build time infrastructure to detect
> inconsistencies if needed.
> 
> Something like:
> #define __suspend     __section(.suspend.text)
> #define __suspenddata __section(.suspend.data)
> 
> #define __hibernate     __section(.hibernate.text)
> #define __hibernatedata __section(.hibernate.data)
> 
> A few more tricks will be needed when we assign the functon pointers.
> We have __devexit_p(*) and we may use something similar.

Unfortunately, I have a little experience with linkers and I don't think I'll
be able to do anything like this in a reasonable time without any help.

Thanks,
Rafael
