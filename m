From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Wed, 12 Mar 2008 22:53:06 +0100
Message-ID: <200803122253.07631.rjw__20527.3569947623$1205358932$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0803121055510.4595-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0803121055510.4595-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 12 of March 2008, Alan Stern wrote:
> On Wed, 12 Mar 2008, Huang, Ying wrote:
> 
> > I think "kexec based hibernation" is the only currently available
> > possible method to write out image without freezer (after driver works
> > are done). If other process is running, how to prevent them from writing
> > to disk without freezing them in current implementation?
> 
> This is a very good question.
> 
> It's a matter of managing the block layer's request queues.  Somehow 
> the existing I/O requests must remain blocked while the requests needed 
> for writing the image must be allowed to proceed.
> 
> I don't know what would be needed to make this work, but it ought to be 
> possible somehow...

Yes, it ought to be possible.

Ultimately, IMHO, we should put all devices unnecessary for saving the image
(and doing some eye-candy work) into low power states before the image is
created and keep them in low power states until the system is eventually
powered off.

If this is done, the remaining problem is the handling of the devices that we
need to save the image.  I believe that will be achievable without using the
freezer.

Thanks,
Rafael
