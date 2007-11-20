From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Question about process freezing
Date: Tue, 20 Nov 2007 10:37:45 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0711201036340.3931-100000@iolanthe.rowland.org>
References: <4742A4B4.6010308@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4742A4B4.6010308@gmail.com>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 20 Nov 2007, Franck Bui-Huu wrote:

> Hi,
> 
> I have a simple/dumb question about process freezing.
> 
> Instead of freezing every single user land processes by sending them a
> fake signal and waiting for them to go to the refrigerator, why not
> freezing the scheduler ?

Because processes can't simply be frozen immediately.  They need to 
have a chance to release any important locks or mutexes they may be 
holding.

Alan Stern
