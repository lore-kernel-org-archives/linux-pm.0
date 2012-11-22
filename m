From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCHv9 1/3] Runtime Interpreted Power Sequences
Date: Thu, 22 Nov 2012 13:39:41 +0000
Message-ID: <20121122133941.24B883E129E@localhost>
References: <1353149747-31871-1-git-send-email-acourbot@nvidia.com>
 <1353149747-31871-2-git-send-email-acourbot@nvidia.com>
 <20121120215429.B621F3E1821@localhost> <13540495.epaCf4JVn9@percival>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <13540495.epaCf4JVn9@percival>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 21 Nov 2012 13:23:06 +0900, Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> Hi Grant,
> 
> On Wednesday 21 November 2012 05:54:29 Grant Likely wrote:
> > > With the advent of the device tree and of ARM kernels that are not
> > > board-tied, we cannot rely on these board-specific hooks anymore but
> > 
> > This isn't strictly true. It is still perfectly fine to have board
> > specific code when necessary. However, there is strong encouragement to
> > enable that code in device drivers as much as possible and new board
> > files need to have very strong justification.
> 
> But doesn't introducing board-specific code into the kernel just defeats the 
> purpose of the DT? If we extend this logic, we are heading straight back to 
> board-definition files. To a lesser extent than before I agree, but the problem 
> is fundamentally the same.

There is *always* board specific code. There is always something fiddly
enough, complex enough, or just plain ugly enough that it is best
handled in C code. The trick is to make the board-specific stuff the
exception, not the rule.

When you can factor out common behavour (like you are doing here), then
it is a really good candidate for a common binding, but still please
always ask yourself the question is this going to make things better or
worse in the long run.

> > I'm thinking about the scripts as trivial-to-parse ascii strings that
> > have a very simple set of commands. The commands use resources already
> > defined in the node. ie. 'g0' refers to the first entry in the gpios
> > property. 'r0' for the regulator, 'p0' for the pwms, 'd' means delay. By
> > no means take this as the format to use, it is just an example off the
> > top of my head, but it is already way easier to work with than putting
> > each command into a node.
> 
> I'd argue that this opens the door wide open towards having a complete 
> interpreter in the device tree. At least DT nodes restrict what we can do 
> conveniently.

I disagree... see below.

> > The trick is still to define a syntax that doesn't fall apart when it
> > needs to be extended. I would also like to get opinions on whether or
> > not conditionals or loops should be supported (ie. loop waiting for a
> > status to change). If they should then we need to be a lot more careful
> > about the design (and due to my aforementioned nervousness, somebody may
> > need to get me therapy).
> 
> That's IMHO the main argument in favor of using DT nodes here (the syntax 
> extension, not your therapy).

hahaha :-)

> They can be extended simply by adding properties 
> to them, and I was relying on this to make power seqs extensible while keeping 
> things consistent (and backward-compatible). For instance, when we want to 
> support voltage setting in regulators we can just add a "voltage" property for 
> that.
> 
> So to sum up the pros of the current node-base representation:
> - give a "data like" representation of powering sequences (what they should 
> be, actually)
> - puts sanity barriers for not turning power seqs into a real code interpreter
> - easily extensible
> 
> There are probably a few cons, the numbering of steps being one, but at least 
> we don't need to design a new DSL and care too much about extensibility which 
> is, in the nodes case, built-in and free.

No matter how it is encoded, this *IS* a new DSL. Using nodes and
properties doesn't change that. Extensibility is no more built-in and
free with nodes that it is with another encoding. If there aren't clear
guidelines on how to extend it then we'll get weird stuff. For example,
even with the nodes case someone might do this:

	step3 {
		type = "loop";
		count = 10;
		step1 {
			type = "gpio";
			gpio = <&gpio 1>;
			value = 1;
		};
		step2 {
			type = "delay";
			value = 10000;
		};
		step3 {
			type = "gpio";
			gpio = <&gpio 1>;
			value = 0;
		};
		step4 {
			type = "delay";
			value = 10000;
		};
	};

And even while cringing as I type the above, I also have to consider
that looping may just be a valid use case for sequences.

And even here, a very simple sequence fragment required 22 lines of
code.

Next, I'm concerned about where these will show up. Say for instance
there needs to be a power sequence added to an spi bus node. Already spi
bus child nodes have a defined meaning; they are spi slaves. How then
should the sequence be attached to the spi bus?

> If that makes you feel better, maybe we can try and fix what is wrong with the 
> current bindings instead of introducing a new language that will be, by 
> nature, more complex to handle and difficult to extend without breaking things?

Okay, here are 3 concrete objections with the proposed binding:
- The syntax concerns of it being too verbose and it effectively uses
  line numbers for ordering (Do you remember fighting with BASIC?).
- There are many devices that won't be able to use the binding because
  they already have a meaning for child nodes
- I think resources should be declared separate from the sequence based
  on the assumption that multiple steps will be operating on the same
  resource.

I do think that each sequence should be contained within a single
property, but I'm open to other suggestions.

g.
