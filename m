From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2 1/2] Input: gpio-keys - allow platform to
 specify exact irq flags
Date: Tue, 1 Dec 2009 10:11:50 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912011011390.2983-100000__35866.5614425719$1259680386$gmane$org@iolanthe.rowland.org>
References: <873a3v2eij.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <873a3v2eij.fsf@tac.ki.iif.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: linux-pm@lists.linux-foundation.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 1 Dec 2009, Ferenc Wagner wrote:

> Alan Stern <stern@rowland.harvard.edu> writes:
> 
> > Runtime PM is not well suited for this purpose.
> 
> So the question is: is there some other PM framework which would be a
> good fit for this "forced manual selective suspend" use case?

None that I know of.

Alan Stern
