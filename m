From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Hibernation considerations
Date: Mon, 16 Jul 2007 10:15:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707161013440.3410-100000__30803.6500624896$1184595408$gmane$org@iolanthe.rowland.org>
References: <200707160938.16037.nigel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707160938.16037.nigel@nigel.suspend2.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <nigel@nigel.suspend2.net>
Cc: david@lang.hm, Al Boldi <a1426z@gawab.com>, LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Mon, 16 Jul 2007, Nigel Cunningham wrote:

> > As I understand it, running a different OS between the hibernate and 
> > the resume would violate the ACPI spec.
> 
> Well then, I know one or two people who would argue that the ACPI spec is 
> faulty. :\

It's hard to argue against that.  In fact there are people who would 
argue that the ACPI spec is incomplete and inconsistent period, 
regardless of any questions about what happens between hibernate and 
resume.  :-)

Alan Stern
