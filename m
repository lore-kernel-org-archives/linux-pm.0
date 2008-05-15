From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Thu, 15 May 2008 10:14:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0805151012150.2107-100000__36224.0373543047$1210861112$gmane$org@iolanthe.rowland.org>
References: <m13aok1pt1.fsf@frodo.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <m13aok1pt1.fsf@frodo.ebiederm.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 14 May 2008, Eric W. Biederman wrote:

> My take on the situation is this.  For proper handling we
> need driver device_detach and device_reattach methods.
> 
> With the following semantics.  The device_detach methods
> will disable DMA and place the hardware in a sane state
> from which the device driver can reclaim and reinitialize it,
> but the hardware will not be touched.
> 
> device_reattach reattaches the driver to the hardware.

How would these differ from the already-existing remove and probe 
methods?

Alan Stern
