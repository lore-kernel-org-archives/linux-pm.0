From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Question about process freezing
Date: Wed, 21 Nov 2007 14:58:07 +0100
Message-ID: <200711211458.08243.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0711201036340.3931-100000@iolanthe.rowland.org>
	<4743E252.2010805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4743E252.2010805@gmail.com>
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
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, 21 of November 2007, Franck Bui-Huu wrote:
> Alan Stern wrote:
> > On Tue, 20 Nov 2007, Franck Bui-Huu wrote:
> >> Instead of freezing every single user land processes by sending them a
> >> fake signal and waiting for them to go to the refrigerator, why not
> >> freezing the scheduler ?
> > 
> > Because processes can't simply be frozen immediately.  They need to 
> > have a chance to release any important locks or mutexes they may be 
> > holding.
> > 
> 
> You mean any locks held by a frozen process and needed by the suspend
> code path ?

Yes.

Regards,
Rafael
