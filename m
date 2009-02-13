From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Fri, 13 Feb 2009 19:14:26 +0000
Message-ID: <20090213191426.GA1379@srcf.ucam.org>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200902131746.42914.u.luckas@road.de>
	<20090213170518.GA29902@srcf.ucam.org>
	<200902131913.54154.u.luckas@road.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200902131913.54154.u.luckas@road.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Uli Luckas <u.luckas@road.de>
Cc: Brian Swetland <swetland@google.com>, linux-pm@lists.linux-foundation.org, "ncunningham@crca.org.au" <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 13, 2009 at 07:13:52PM +0100, Uli Luckas wrote:
> On Friday, 13. February 2009, Matthew Garrett wrote:
> >
> > The daemon holds the lock in the first place.
> When did the daemon take the lock? When it anticipated the process would 
> crash?

When it was first asked to. In this model invidual applications wouldn't 
take locks themselves - it would be up to the daemon to handle the 
kernel interaction.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
