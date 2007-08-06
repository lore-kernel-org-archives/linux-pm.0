From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: Re: Possible problem with device_move()
Date: Mon, 6 Aug 2007 11:31:41 +0200
Message-ID: <20070806113141.2289e5e3@gondolin.boeblingen.de.ibm.com>
References: <Pine.LNX.4.44L0.0708031042440.2597-100000@iolanthe.rowland.org>
	<200708032339.32161.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708032339.32161.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Marcel Holtmann <marcel@holtmann.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 3 Aug 2007 23:39:31 +0200,
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> > Suggested functions:
> > 
> >      1. Move A in front of B, together with all of A's ancestors which
> > 	aren't already ahead of B (or maybe require that A's parent be
> > 	ahead of B already).

I'd prefer "move includes ancestors" as not to introduce another
possibility where users can get it wrong.

> > 
> >      2. Move device A to the end (A must not have any children).
> > 
> > Anything else?
> 
> Nothing more comes to mind at the moment.
> 
> > I think this will cover all the cases we currently are concerned about.
> 
> I agree.

Yes, I think this should be sufficient.
