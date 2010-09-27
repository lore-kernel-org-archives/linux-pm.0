From: Don Zickus <dzickus@redhat.com>
Subject: Re: hibernation hangs with ATA errors (lockup_detector
	bug)
Date: Mon, 27 Sep 2010 10:21:49 -0400
Message-ID: <20100927142149.GV26290__805.1666002304$1285597453$gmane$org@redhat.com>
References: <4C03C608.1040600@gmail.com> <20100601135004.GP15159@redhat.com>
	<4C051D44.7040203@gmail.com> <20100602184459.GA15159@redhat.com>
	<4C0B3E94.6020506@gmail.com> <4C80B338.6020701@gmail.com>
	<20100903135613.GV4879@redhat.com> <4C9CBF4A.9060302@gmail.com>
	<20100924191946.GS26290@redhat.com> <4C9E4DDB.6070503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4C9E4DDB.6070503@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, Sep 25, 2010 at 10:30:35PM +0300, Jiri Slaby wrote:
> On 09/24/2010 10:19 PM, Don Zickus wrote:
> > Actually there seems to have been some clean up in the cpu hotplug error
> > handling code.  Could you remove that snippet of code and see if the
> > problem still happens?
> 
> The thing is I don't remember what problems exactly I had. From the
> description I wrote, I cannot reproduce it anymore :).
> 
> thanks for looking into that,

ok. :-)  Let me know if it pops up again.

Cheers,
Don
