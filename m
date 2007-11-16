From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: apm emulation driver broken ?
Date: Fri, 16 Nov 2007 17:20:49 +0100
Message-ID: <200711161720.50313.rjw__19600.921116262$1195229105$gmane$org@sisk.pl>
References: <cda58cb80711160706l2cfac2b1p81c7a1090f228f2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <cda58cb80711160706l2cfac2b1p81c7a1090f228f2e@mail.gmail.com>
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
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Friday, 16 of November 2007, Franck Bui-Huu wrote:
> Rafael,
> 
> Looking at commit:
> 
> 	831441862956fffa17b9801db37e6ea1650b0f69
> 	Freezer: make kernel threads nonfreezable by default
> 
> it seems that you broke the apm emulation driver.
> 
> You removed PF_NOFREEZE flag setting in apm_ioctl(), which is
> definitely not part of the apm kernel daemon but instead is called by
> user space proccesses...

Yes ...

> I'm just reading this code for the first time so I can be wrong but it
> looks like it's not going to work anymore.
> 
> Could you confirm ?

Well, no, AFAICS.

The freezer doesn't regard the current task as freezable.

Greetings,
Rafael
