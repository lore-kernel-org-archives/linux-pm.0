From: "Amit Kucheria" <kucheria.amit@gmail.com>
Subject: Re: Alternative Concept
Date: Thu, 15 Mar 2007 10:14:57 +0200
Message-ID: <52d486620703150114w2981705eo7f3403721614b0e5@mail.gmail.com>
References: <200703142208.l2EM8uoV007606@olwen.urbana.css.mot.com>
	<200703141623.16643.david-b@pacbell.net>
	<484380240703150025r45f09635o261d42bd4f2b06dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <484380240703150025r45f09635o261d42bd4f2b06dc@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Ikhwan Lee <dlrghks@gmail.com>
Cc: linux-pm@lists.osdl.org, linux@dominikbrodowski.net, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org

On 3/15/07, Ikhwan Lee <dlrghks@gmail.com> wrote:
> Hi,
>
> On 3/15/07, David Brownell <david-b@pacbell.net> wrote:
> >
> > So you think that platforms which don't have such interdependencies
> > should incur costs and complexity to address problems they don't have.
> > Why?
>
> Not every platform implements the clock interface. I think same can be
> done with the proposed power parameter framework. The basic codes
> defining the power parameter interface need not be costly and complex.

Exactly! Maybe once we get to the stage of interface discussion, Matt
and Eugeny could provide a roadmap on the evolution of the PM
framework. Personally, I don't see clock framework disappearing
overnight for platforms that do use it.

/Amit
--
Amit Kucheria, Nokia
