From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFD] Automatic suspend
Date: Mon, 16 Feb 2009 23:26:19 +0000
Message-ID: <20090216232619.GB15678@srcf.ucam.org>
References: <200902160010.16955.rjw@sisk.pl> <20090216225831.GH1370@ucw.cz>
	<20090216231324.GA15435@srcf.ucam.org>
	<20090216232259.GK1370@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090216232259.GK1370@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@suse.cz>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 17, 2009 at 12:22:59AM +0100, Pavel Machek wrote:
> On Mon 2009-02-16 23:13:24, Matthew Garrett wrote:
> > Meanwhile, on embedded it's becoming a less interesting problem because 
> > idle and suspended are often now equivalent states. 
> 
> Android people tell us otherwise.

https://lists.linux-foundation.org/pipermail/linux-pm/2009-January/019493.html 
says that they're the same on their current platform.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
