From: Oliver Neukum <oliver@neukum.org>
Subject: Re: parallel suspend/resume
Date: Sat, 8 Dec 2007 13:26:01 +0100
Message-ID: <200712081326.02042.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0712071120400.4209-100000@iolanthe.rowland.org>
	<20071208102143.GA7195@elf.ucw.cz>
	<475A7B39.7030106@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <475A7B39.7030106@superbug.co.uk>
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
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Am Samstag, 8. Dezember 2007 12:08:41 schrieb James Courtier-Dutton:
> Pavel Machek wrote:
> > On Sat 2007-12-08 09:00:44, Oliver Neukum wrote:
> >   
> >> Am Freitag, 7. Dezember 2007 19:01:12 schrieb David Brownell:
> >>     
> >>> FWIW the appended patch removes that rude "order of registration"
> >>> policy, so that the suspend/resume list matches the device tree.
> >>> It's behaved OK on PCs and, in light duty, a few development boards;
> >>> I've carried it around most of this year.
> >>>       
> >> As it is a tree, why not store it as such?
> >>     
> >
> > IIRC because we do not want recursive tree walkers in the kernel --
> > stack limits.
> >
> >   
> 
> Surely it is possible to code a tree walker that is not a recursive 
> function?
> I believe you can use a simple loop and the heap to store state that 
> would otherwise be stored on the stack in a recursive function.

If you store a pointer to the parent in each node, you can do with
static memory of only the current node and the previous node.

	Regards
		Oliver
